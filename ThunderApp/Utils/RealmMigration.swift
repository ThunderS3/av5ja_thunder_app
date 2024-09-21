//
//  RealmMigration.swift
//  Salmonia3+
//  
//  Created by devonly on 2024/06/02.
//  Copyright © 2024 Magi. All rights reserved.
//

import Foundation
import RealmSwift
import Firebolt

enum RealmMigration {
    private static let version: String = (Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? "1.0.0")
    private static let schemaVersion: UInt64 = UInt64(version.split(separator: ".").compactMap { Int($0) }.map { String(format: "%02d", $0) }.joined(), radix: 16) ?? 0

    static let configuration: Realm.Configuration = .init(
        encryptionKey: SecretKeys.realmEncryptionKey,
        readOnly: false,
        schemaVersion: schemaVersion,
        migrationBlock: migrationBlock(),
        deleteRealmIfMigrationNeeded: true
    )
    
#if targetEnvironment(simulator)
    static let realm: Realm = try! .init()
//    static let realm: Realm = try! .init(configuration: configuration)
#else
    static let realm: Realm = try! .init(configuration: configuration)
#endif
    
    static func migrationBlock() -> MigrationBlock? {
        return { _, _ in
        }
    }
}
