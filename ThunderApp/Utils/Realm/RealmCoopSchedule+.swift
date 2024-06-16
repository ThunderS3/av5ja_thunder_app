//
//  RealmCoopSchedule+.swift
//  ThunderApp
//
//  Created by devonly on 2024/06/14.
//  Copyright © 2024 Magi. All rights reserved.
//

import Foundation
import RealmSwift
import Thunder

extension RealmCoopSchedule {
    /// スケジュールがランダム編成かどうか
    var isRandom: Bool {
        weaponList.contains(.RandomGold) || weaponList.contains(.RandomGreen)
    }

    var isBigRun: Bool {
        stageId.isBigRun
    }
    
    //    var maxGradeId: CoopGrade.Id? { results.maxGradeId }
    //
    //    var maxGradePoint: Int? { results.maxGradePoint }
    //
    //    var maxGoldenIkuraNum: Int? { results.goldenIkuraNum.max }

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
}
