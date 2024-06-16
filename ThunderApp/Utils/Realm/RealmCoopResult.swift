//
//  RealmCoopResult.swift
//  Salmonia3+
//
//  Created by devonly on 2023/09/26
//  Copyright © 2023 Magi Corporation. All rights reserved.
//

import Foundation
import RealmSwift
import Firebolt
import Thunder
import Realm.Private

final class RealmCoopResult: Object, Codable, Identifiable {
    @Persisted(primaryKey: true) var id: String
    @Persisted var uuid: UUID
    @Persisted var nplnUserId: String
    @Persisted var gradePoint: Int?
    @Persisted var gradeId: CoopGrade.Id?
    @Persisted var isClear: Bool
    @Persisted var failureWave: Int?
    @Persisted var bossId: CoopBossInfo.Id?
    @Persisted var isBossDefeated: Bool?
    @Persisted var ikuraNum: Int
    @Persisted var stageId: CoopStage.Id
    @Persisted(indexed: true) var goldenIkuraNum: Int
    @Persisted var goldenIkuraAssistNum: Int?
    @Persisted var bossCounts: List<Int>
    @Persisted var bossKillCounts: List<Int>
    @Persisted var dangerRate: Decimal128?
    @Persisted var jobRate: Decimal128?
    @Persisted var jobScore: Int?
    @Persisted var kumaPoint: Int?
    @Persisted var jobBonus: Int?
    @Persisted var smellMeter: Int?
    @Persisted var waves: List<RealmCoopWave>
    @Persisted var players: List<RealmCoopPlayer>
    @Persisted var scale: List<Int?>
    @Persisted var playTime: Date
    @Persisted var scenarioCode: String?
    @Persisted(originProperty: "results") private var schedules: LinkingObjects<RealmCoopSchedule>

    override init() {
        super.init()
    }

    convenience init(result: CoopHistoryDetailQuery.Response) {
        self.init()
        self.id = result.hash
        self.uuid = result.id.uuid
        self.nplnUserId = result.id.nplnUserId
        self.isClear = result.jobResult.isClear
        self.failureWave = result.jobResult.failureWave
        self.bossId = result.jobResult.bossId
        self.stageId = result.schedule.stageId
        self.isBossDefeated = result.jobResult.isBossDefeated
        self.ikuraNum = result.ikuraNum
        self.goldenIkuraNum = result.goldenIkuraNum
        self.goldenIkuraAssistNum = result.goldenIkuraAssistNum
        self.dangerRate = result.dangerRate.decimal128
        self.playTime = result.id.playTime
        self.scale = .init(contentsOf: result.scale)
        self.bossCounts.append(objectsIn: result.bossCounts)
        self.bossKillCounts.append(objectsIn: result.bossKillCounts)
        self.scenarioCode = result.scenarioCode
    
        self.jobRate = result.myResult.jobRate?.decimal128
        self.jobBonus = result.myResult.jobBonus
        self.jobScore = result.myResult.jobScore
        self.kumaPoint = result.myResult.kumaPoint
        self.gradePoint = result.myResult.gradePoint
        self.gradeId = result.myResult.gradeId
        self.smellMeter = result.myResult.smellMeter

        self.players = .init(contentsOf: result.members.map(\.object))
        self.waves = .init(contentsOf: result.waveDetails.map(\.object))
    }

    private enum CodingKeys: String, CodingKey {
        case id
        case uuid
        case nplnUserId
        case gradePoint
        case gradeId
        case isClear
        case failureWave
        case bossId
        case isBossDefeated
        case ikuraNum
        case goldenIkuraNum
        case goldenIkuraAssistNum
        case dangerRate
        case playTime
        case scale
        case bossCounts
        case bossKillCounts
        case scenarioCode
        case players
        case waves
    }

    func encode(to encoder: Encoder) throws {
        var encoder = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encode(id, forKey: .id)
        try encoder.encode(uuid, forKey: .uuid)
        try encoder.encode(nplnUserId, forKey: .nplnUserId)
        try encoder.encode(gradePoint, forKey: .gradePoint)
        try encoder.encode(gradeId, forKey: .gradeId)
        try encoder.encode(isClear, forKey: .isClear)
        try encoder.encode(failureWave, forKey: .failureWave)
        try encoder.encode(bossId, forKey: .bossId)
        try encoder.encode(isBossDefeated, forKey: .isBossDefeated)
        try encoder.encode(ikuraNum, forKey: .ikuraNum)
        try encoder.encode(goldenIkuraNum, forKey: .goldenIkuraNum)
        try encoder.encode(goldenIkuraAssistNum, forKey: .goldenIkuraAssistNum)
        try encoder.encode(dangerRate, forKey: .dangerRate)
        try encoder.encode(playTime, forKey: .playTime)
        try encoder.encode(scale, forKey: .scale)
        try encoder.encode(bossCounts, forKey: .bossCounts)
        try encoder.encode(bossKillCounts, forKey: .bossKillCounts)
        try encoder.encode(scenarioCode, forKey: .scenarioCode)
        try encoder.encode(players, forKey: .players)
        try encoder.encode(waves, forKey: .waves)
    }
}

// extension CoopHistoryDetailQuery.Response { var object: RealmCoopResult { .init(result: self) } }

// extension CoopHistoryQuery.CoopResult {
//    var object: RealmCoopResult {
//        .init(result: self)
//    }
// }

extension Decimal {
    var decimal128: Decimal128 {
        Decimal128(value: self)
    }
}

//extension Optional where Wrapped == Decimal {
//    var decimal128: Decimal128? {
//        if let value: Decimal = self {
//            return Decimal128(value: value)
//        }
//        return nil
//    }
//}

//extension RealmSwift.List where Element == RealmCoopResult {
//    func append<S: Sequence>(objectsIn objects: S) where S.Iterator.Element == CoopHistoryDetailQuery.Response {
//        objects.forEach({ object in
//            let data: RealmCoopResult = .init(result: object)
//        })
//    }
//}

extension RealmCoopResult {
    /// スケジュール
    private var schedule: RealmCoopSchedule {
        schedules.first ?? .preview
    }

    var weaponList: List<WeaponInfoMain.Id> {
        schedule.weaponList
    }
    
    var player: RealmCoopPlayer {
        players.first(where: { $0.isMyself }) ?? .preview
    }
}
     //
//    /// ステージID
//    var stageId: CoopStage.Id { schedule.stageId }
//
//    /// リザルトID
//    var resultId: CoopHistoryDetail.Id { .init(nplnUserId: nplnUserId, playTime: playTime, uuid: uuid) }
//
//    /// スケジュールのブキ一覧
//    var weaponList: RealmSwift.List<WeaponInfoMain.Id> { schedule.weaponList }
//
//    /// isMyselfがTrueのプレイヤー
//    var player: RealmCoopPlayer {
//        players.first(where: { $0.isMyself }) ?? .preview(specialId: .SpCastle, specialCounts: [1, 1, 0])
//    }
//
//    var specialCounts: [[WeaponInfoSpecial.Id]] {
//        let usages: [[[WeaponInfoSpecial.Id]]] = players.map({ player -> [[WeaponInfoSpecial.Id]] in
//            player.specialCounts.map({ Array(repeating: player.specialId ?? .RandomGreen, count: $0) })
//        })
//        return usages.transposed().map({ $0.flatMap({ $0 }) })
//    }
//
//    static func preview(isClear: Bool) -> RealmCoopResult {
//        let result: RealmCoopResult = .init()
//        result.id = ""
//        result.uuid = .init()
//        result.nplnUserId = "a7grz65rxkvhfsbwmxmm"
//        result.gradePoint = 999
//        result.gradeId = .Grade08
//        result.isClear = isClear
//        result.failureWave = nil
//        result.bossId = .SakeJaw
//        result.isBossDefeated = true
//        result.ikuraNum = 9_999
//        result.goldenIkuraNum = 999
//        result.goldenIkuraAssistNum = 999
//        result.dangerRate = 3.33
//        result.jobRate = 3.45
//        result.kumaPoint = 999
//        result.smellMeter = 5
//        result.scale.append(objectsIn: [99, 99, 99])
//        result.playTime = .init()
//        result.bossCounts = .init(contentsOf: Array(repeating: 0, count: 14).map({ _ in Int.random(in: 0...10) }))
//        result.bossKillCounts = .init(contentsOf: Array(repeating: 0, count: 14).map({ _ in Int.random(in: 0...10) }))
//        result.scenarioCode = nil
//        result.waves = .init(contentsOf: [
//            .preview(waterLevel: .HighTide, eventType: .Rush, waveId: 1),
//            .preview(waterLevel: .NormalTide, eventType: .GoldieSeeking, waveId: 2),
//            .preview(waterLevel: .LowTide, eventType: .Fog, waveId: 3),
//            .preview(waterLevel: .LowTide, eventType: .WaterLevels, waveId: 4),
//        ])
//        result.players = .init(contentsOf: [
//            .preview(specialId: .SpCastle, specialCounts: [2, 1, 1, 1]),
//            .preview(specialId: .SpSkewer, specialCounts: [2, 1, 0, 1]),
//            .preview(specialId: .SpChariot, specialCounts: [2, 0, 1, 1]),
//            .preview(specialId: .SpJetpack, specialCounts: [2, 0, 0, 1]),
//        ])
//        return result
//    }
// }
