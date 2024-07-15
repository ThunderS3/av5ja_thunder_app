//
//  Statics.swift
//  ThunderApp
//  
//  Created by devonly on 2024/07/14.
//  Copyright © 2024 Magi. All rights reserved.
//

import Foundation
import Thunder

internal struct Statics {
    let max: Int?
    let sum: Int?
    let avg: Double?
}

internal struct PointCard {
    let shiftWorked: Int?
    let goldenIkuraNum: Int?
    let ikuraNum: Int?
    let bossKillCount: Int?
    let kingKillCount: Int?
    let helpCount: Int?
    let deathCount: Int?
    let kumaPoint: Int?
}

internal struct BossList: Identifiable, Equatable, Hashable {
    let id: CoopEnemyInfo.Id
    let player: Int?
    let team: Int?
    let appear: Int?
}

struct SpecialList: Identifiable, Equatable, Hashable {
    let id: WeaponInfoSpecial.Id
    let count: Int?
    let percent: Double?
}

struct WeaponList: Identifiable, Equatable, Hashable {
    let id: WeaponInfoMain.Id
    let count: Int?
    let percent: Double?
}

extension Array where Element == WeaponList {
    /// ランダム編成をコンプリートしたかどうか
    var isCompleted: Bool { filter({ $0.count == nil || $0.count == 0 }).isEmpty }

    /// 支給されたブキの数
    var suppliedCount: Int { filter({ $0.count != nil && $0.count != 0 }).count }
}
