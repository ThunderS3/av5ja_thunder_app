//
//  RealmCoopSchedule.swift
//  Salmonia3+
//
//  Created by devonly on 2023/09/26
//  Copyright © 2023 Magi Corporation. All rights reserved.
//

import Foundation
import RealmSwift
import Thunder

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

    override init() { super.init() }

//    convenience init(schedule: StageScheduleQuery.Schedule) {
//        self.init()
//        self.id = schedule.id
//        self.startTime = schedule.startTime
//        self.endTime = schedule.endTime
//        self.stageId = schedule.stageId
//        self.bossId = schedule.bossId
//        self.weaponList.append(objectsIn: schedule.weaponList)
//        self.rareWeapons.append(objectsIn: schedule.rareWeapons)
//        self.results.append(objectsIn: [])
//        self.rule = schedule.rule
//        self.mode = schedule.mode
//    }

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

// extension RealmCoopSchedule {
//    /// スケジュールがランダム編成かどうか
//    var isRandom: Bool { weaponList.contains(.RandomGold) || weaponList.contains(.RandomGreen) }
//
//    var isBigRun: Bool { CoopStage.Id.bigRun.contains(stageId) }
//
//    var maxGradeId: CoopGrade.Id? { results.maxGradeId }
//
//    var maxGradePoint: Int? { results.maxGradePoint }
//
//    var maxGoldenIkuraNum: Int? { results.goldenIkuraNum.max }
//
//    static let preview: RealmCoopSchedule = {
//        let schedule: RealmCoopSchedule = .init()
//        schedule.weaponList.append(objectsIn: Array(repeating: .RandomGold, count: 4))
//        schedule.rule = .REGULAR
//        schedule.mode = .REGULAR
//        schedule.stageId = .Shakedent
//        schedule.bossId = .SakeJaw
//        schedule.rareWeapons.append(objectsIn: [
//            .BlasterBear, .ChargerBear, .ShelterBear, .SlosherBear, .ManeuverBear, .StringerBear, .SaberBear,
//        ])
//        schedule.startTime = Date(rawValue: "2023-12-09 00:00:00 +0000")
//        schedule.endTime = Date(rawValue: "2023-12-10 16:00:00 +0000")
//        return schedule
//    }()
// }
//
// extension StageScheduleQuery.Schedule { var object: RealmCoopSchedule { RealmCoopSchedule(schedule: self) } }
