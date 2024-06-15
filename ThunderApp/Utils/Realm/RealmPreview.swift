//
//  RealmPreview.swift
//  ThunderApp
//
//  Created by devonly on 2024/06/14.
//  Copyright © 2024 Magi. All rights reserved.
//

import Foundation
import RealmSwift
import Firebolt

extension RealmCoopSchedule {
    static let preview: RealmCoopSchedule = {
        let value: [String: Any] = [
            "id": "ed303b70f9a9f6d8a799becf56227898",
            "startTime": "2024-06-20T00:00:00Z",
            "endTime": "2024-06-21T16:00:00Z",
            "mode": "REGULAR",
            "rule": "REGULAR",
            "bossId": 24,
            "stageId": 6,
            "rareWeapons": [],
            "weaponList": [30, 6000, 1010, 2030]
        ]
        let object: [String: Any] = Mirror(reflecting: value).children.reduce(
            into: [String: Any](),
            { results, result in
                guard let key: String = result.label else { return }
                results[key] = result.value
            }
        )
        return .init(value: object)
    }()
}

extension RealmCoopResult {
    static let preview: RealmCoopResult = {
        let decoder: JSONDecoder = .init()
        decoder.dateDecodingStrategy = .atom
        guard let path: String = Bundle.main.path(forResource: "results", ofType: "json"),
              let data: Data = try? .init(contentsOf: .init(fileURLWithPath: path)),
              let result: CoopHistoryDetailQuery.Response = try? decoder.decode(CoopHistoryDetailQuery.Response.self, from: data)
        else {
            fatalError("Not Found")
        }
        return .init(result: result)
    }()
}

extension RealmCoopWave {
    static let preview: RealmCoopWave = {
        let value: [String: Any] = [
            "waterLevel": 0,
            "eventType": 0,
            "quotaNum": 27,
            "goldenIkuraPopNum": 66,
            "goldenIkuraNum": 42,
            "id": 1,
            "isClear": true,
            "hash": "fcfa40cc4412c47f0577c9185436aad2"
        ]
        return .init(value: value)
    }()
}
