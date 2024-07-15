//
//  RealmSigner.swift
//  ThunderApp
//  
//  Created by devonly on 2024/07/15.
//  Copyright © 2024 Magi. All rights reserved.
//

import CryptoKit
import Foundation
import RealmSwift
import Firebolt
import ZIPFoundation
import SwiftPackageKeys
import Mudmouth
import SwiftUI

final class RealmSigner {
    private static let realm: Realm = RealmMigration.realm
    // swiftlint:disable:next force_try
    private static let privateKey: Curve25519.Signing.PrivateKey = try! .init(rawRepresentation: SecretKeys.privateKey)
    private static let publicKey: Data = privateKey.publicKey.rawRepresentation
    private static let decoder: JSONDecoder = .init(dateDecodingStrategy: .iso8601)
    private static let encoder: JSONEncoder = .init(dateEncodingStrategy: .iso8601)
    private static let manager: FileManager = .default

    private init() {}

    /// 作成したバックアップを削除する
    @MainActor
    class func deleteAll() throws {
        guard
            let baseURL = try? manager.url(
                for: .cachesDirectory,
                in: .userDomainMask,
                appropriateFor: nil,
                create: false
            ),
            let documentURLs = try? manager.contentsOfDirectory(at: baseURL, includingPropertiesForKeys: nil).filter({
                ($0.pathExtension == "zip" || $0.pathExtension == "json")
                    && !$0.lastPathComponent.capture(pattern: #"[0-9]{14}"#).isEmpty
            })
        else { return }
        for documentURL in documentURLs {
            if manager.fileExists(atPath: documentURL.path) { try? manager.removeItem(atPath: documentURL.path) }
        }
    }

    /// リストア
    /// - Parameter source: データのURL
    @MainActor
    class func restore(url sourceURL: URL) async throws {
        let filename: String = sourceURL.deletingPathExtension().lastPathComponent
        guard let cacheURL: URL = manager.urls(for: .cachesDirectory, in: .userDomainMask).first
        else {
            throw SPError.FileNotFound
        }
        let destinationURL: URL = cacheURL.appendingPathComponent(filename)
        if manager.fileExists(atPath: destinationURL.path) {
            try manager.removeItem(atPath: destinationURL.path)
        }
        try await unzip(at: sourceURL, to: destinationURL, skipCRC32: false, progress: nil, pathEncoding: .utf8)
        guard let fileURL: URL = try manager.contentsOfDirectory(at: destinationURL, includingPropertiesForKeys: [.isRegularFileKey]).first
        else {
            throw SPError.FileNotFound
        }
        let data: Data = try .init(contentsOf: fileURL)
        try verify(data: data)
        let result: SignedRealmCoopResult = try decoder.decode(SignedRealmCoopResult.self, from: data)
        try inWriteTransaction(transaction: {
            result.schedules.forEach({ schedule in
                realm.create(RealmCoopSchedule.self, value: schedule, update: .modified)
//                realm.update(RealmCoopSchedule.self, value: schedule, update: .modified)
            })
        })
    }

    /// バックアップ
    /// - Returns: データのURL
    @MainActor
    class func backup() async throws -> URL {
        let schedules: RealmSwift.Results<RealmCoopSchedule> = realm.objects(RealmCoopSchedule.self)
        let data: Data = try await sign(schedules: schedules)
        try verify(data: data)
        let filename: String = {
            let formatter: DateFormatter = .init()
            formatter.dateFormat = "yyyyMMddHHmmss"
            return formatter.string(from: .init())
        }()
        
        guard let baseURL: URL = manager.urls(for: .cachesDirectory, in: .userDomainMask).first else {
            throw SPError.FileNotFound
        }
        let source: URL = baseURL.appendingPathComponent(filename, conformingTo: .json)
        try data.write(to: source)
        let destination: URL = baseURL.appendingPathComponent(filename, conformingTo: .zip)
        return try await zip(at: source, to: destination, shouldKeepParent: false, complessionMethod: .deflate)
    }
    
    
    private class func unzip(at: URL, to: URL, skipCRC32: Bool, progress: Progress?, pathEncoding: String.Encoding) async throws {
        try await Task(priority: .background, operation: {
            try manager.unzipItem(at: at, to: to, skipCRC32: skipCRC32, progress: progress, pathEncoding: pathEncoding)
        }).value
    }
    private class func zip(at: URL, to: URL, shouldKeepParent: Bool, complessionMethod: CompressionMethod) async throws -> URL {
        try await Task(priority: .background, operation: {
            try manager.zipItem(at: at, to: to, shouldKeepParent: shouldKeepParent, compressionMethod: complessionMethod)
            return to
        }).value
    }

    /// 署名
    /// - Parameter schedules: スケジュール
    /// - Returns: データ
    @MainActor
    private class func sign(schedules: RealmSwift.Results<RealmCoopSchedule>) async throws -> Data {
        let ref = ThreadSafeReference(to: schedules)
        return try await Task(priority: .high, operation: {
            guard let schedules: RealmSwift.Results<RealmCoopSchedule> = realm.resolve(ref) else {
                throw SPError.EncodingFailed
            }
            let data: Data = try encoder.encode(schedules)
            // swiftlint:disable:next force_try
            let signature: Data = try! privateKey.signature(for: data)
            return try encoder.encode(SignedRealmCoopResult(signature: signature, schedules: schedules))
        }).value
    }

    /// 署名検証
    /// - Parameter data: データ
    @MainActor
    private class func verify(data: Data) throws {
        // swiftlint:disable:next force_try
        let publicKey: Curve25519.Signing.PublicKey = try .init(rawRepresentation: publicKey)
        // swiftlint:disable:next force_try
        let result: SignedRealmCoopResult = try decoder.decode(SignedRealmCoopResult.self, from: data)
        // swiftlint:disable:next force_try
        let data: Data = try encoder.encode(result.schedules)
        if publicKey.isValidSignature(result.signature, for: data) {
            throw SPError.InvalidSignature
        }
        return
    }

    /// 書き込み用のトランザクション
    /// - Parameter writeBlock: トランザクション
    @MainActor
    private static func inWriteTransaction(transaction writeBlock: () throws -> Void) throws {
        if realm.isInWriteTransaction {
            try writeBlock()
        } else {
            realm.beginWrite()
            try writeBlock()
            try realm.commitWrite()
        }
    }
}

extension SecretKeys {
    static let privateKey: Data = {
        guard let value: String = SwiftPackageKeys.privateKey.value
        else {
            fatalError("PrivateKey is not set")
        }
        // swiftlint:disable:next force_unwrapping
        return value.data(using: .utf8)!
    }()
    
    static let realmEncryptionKey: Data = {
        guard let value: String = SwiftPackageKeys.realmEncryptionKey.value
        else {
            fatalError("RealmEncryptionKey is not set")
        }
        // swiftlint:disable:next force_unwrapping
        return value.data(using: .utf8)!
    }()
}
