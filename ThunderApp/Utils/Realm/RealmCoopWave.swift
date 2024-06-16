//
//  RealmCoopWave.swift
//  Salmonia3+
//
//  Created by devonly on 2023/12/05
//  Copyright © 2023 Magi Corporation. All rights reserved.
//

import Foundation
import RealmSwift
import Thunder
import Firebolt

final class RealmCoopWave: Object, Identifiable, Codable {
    @Persisted(primaryKey: true) var id: String
    @Persisted var waveId: Int
    @Persisted var isClear: Bool
    @Persisted(indexed: true) var waterLevel: CoopWaterLevel.Id
    @Persisted(indexed: true) var eventType: CoopEvent.Id
    @Persisted(indexed: true) var goldenIkuraNum: Int?
    @Persisted var quotaNum: Int?
    @Persisted var goldenIkuraPopNum: Int
    @Persisted(originProperty: "waves") private var results: LinkingObjects<RealmCoopResult>

    override init() { super.init() }

    convenience init(result: CoopHistoryDetailQuery.WaveResult) {
        self.init()
        self.id = result.hash
        self.waveId = result.id
        self.isClear = result.isClear
        self.waterLevel = result.waterLevel
        self.eventType = result.eventType
        self.goldenIkuraNum = result.goldenIkuraNum
        self.goldenIkuraPopNum = result.goldenIkuraPopNum
        self.quotaNum = result.quotaNum
    }

    private enum CodingKeys: String, CodingKey {
        case id
        case waveId
        case isClear
        case waterLevel
        case eventType
        case goldenIkuraNum
        case quotaNum
        case goldenIkuraPopNum
    }

//    init(from decoder: Decoder) throws {}

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(waveId, forKey: .waveId)
        try container.encode(isClear, forKey: .isClear)
        try container.encode(waterLevel, forKey: .waterLevel)
        try container.encode(eventType, forKey: .eventType)
        try container.encode(goldenIkuraNum, forKey: .goldenIkuraNum)
        try container.encode(goldenIkuraPopNum, forKey: .goldenIkuraPopNum)
        try container.encode(quotaNum, forKey: .quotaNum)
    }
}

extension CoopHistoryDetailQuery.WaveResult {
    var object: RealmCoopWave {
        .init(result: self)
    }
}
//
// extension RealmCoopWave {
//    private var result: RealmCoopResult { link.first ?? .preview(isClear: true) }
//
//    var specialCounts: [WeaponInfoSpecial.Id] { result.specialCounts[waveId - 1] }
//
//    var isExtraWave: Bool { quotaNum == nil }
//
//    static func preview(waterLevel: CoopWaterLevel.Id, eventType: CoopEvent.Id, waveId: Int) -> RealmCoopWave {
//        let wave: RealmCoopWave = .init()
//        wave.id = UUID().uuidString
//        wave.waveId = waveId
//        wave.isClear = true
//        wave.waterLevel = waterLevel
//        wave.eventType = eventType
//        wave.goldenIkuraNum = 999
//        wave.goldenIkuraPopNum = 999
//        wave.quotaNum = 35
//        return wave
//    }
// }
