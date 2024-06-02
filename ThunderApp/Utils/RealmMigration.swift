//
//  RealmMigration.swift
//  Salmonia3+
//  
//  Created by devonly on 2024/06/02.
//  Copyright © 2024 Magi. All rights reserved.
//

import Foundation
import RealmSwift

enum RealmMigration {
    private static let version: String = (Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? "1.0.0")
    private static let schemaVersion: UInt64 = UInt64(version.split(separator: ".").compactMap { Int($0) }.map { String(format: "%02d", $0) }.joined(), radix: 16) ?? 0

    static let configuration: Realm.Configuration = .init(
        schemaVersion: schemaVersion,
        migrationBlock: migrationBlock(),
        deleteRealmIfMigrationNeeded: false
    )

    static func migrationBlock() -> MigrationBlock? {
        return { _, _ in
        }
    }
}
