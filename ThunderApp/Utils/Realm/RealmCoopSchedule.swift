//
//  RealmCoopSchedule.swift
//  Salmonia3+
//
//  Created by devonly on 2023/09/26
//  Copyright © 2023 Magi Corporation. All rights reserved.
//

import Foundation
import RealmSwift
import Realm.Private
import Thunder
import Firebolt

final class RealmCoopSchedule: Object, Codable, Identifiable {
    @Persisted(primaryKey: true) var id: String
    @Persisted(indexed: true) var startTime: Date?
    @Persisted(indexed: true) var endTime: Date?
    @Persisted var stageId: CoopStage.Id
    @Persisted var bossId: CoopBossInfo.Id?
    @Persisted var weaponList: List<WeaponInfoMain.Id>
    @Persisted var rareWeapons: List<WeaponInfoMain.Id>
    @Persisted var results: List<RealmCoopResult>
    @Persisted var rule: CoopRule
    @Persisted var mode: CoopMode

    override init() {
        super.init()
    }
   
    init<T: Encodable>(schedule: T) {
        super.init()
        RLMInitializeWithValue(self, schedule.dictionaryObject, .partialPrivateShared())
    }
    
    private enum CodingKeys: String, CodingKey {
        case id
        case startTime
        case endTime
        case stageId
        case bossId
        case weaponList
        case rareWeapons
        case results
        case rule
        case mode
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(startTime, forKey: .startTime)
        try container.encode(endTime, forKey: .endTime)
        try container.encode(stageId, forKey: .stageId)
        try container.encode(bossId, forKey: .bossId)
        try container.encode(weaponList, forKey: .weaponList)
        try container.encode(rareWeapons, forKey: .rareWeapons)
        try container.encode(results, forKey: .results)
        try container.encode(rule, forKey: .rule)
        try container.encode(mode, forKey: .mode)
    }
}
