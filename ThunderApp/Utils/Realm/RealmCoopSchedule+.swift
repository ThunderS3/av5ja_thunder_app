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
    
    /// プレイヤー一覧
    func players(_ isMyself: Bool) -> RealmSwift.List<RealmCoopPlayer> {
        isMyself ? .init(contentsOf: results.map(\.player)) : .init(contentsOf: results.flatMap(\.players))
    }
    
    /// ビッグランかどうか
    var isBigRun: Bool {
        stageId.isBigRun
    }
    
    /// クマサンポイントカードの情報
    var pointCard: PointCard {
        .init(
            shiftWorked: results.size,
            goldenIkuraNum: players(true).sumValue(ofProperty: "goldenIkuraNum"),
            ikuraNum: players(true).sumValue(ofProperty: "ikuraNum"),
            bossKillCount: players(true).sumValue(ofProperty: "bossKillCountsTotal"),
            kingKillCount: results.sumValue(ofProperty: "goldenIkuraNum"),
            helpCount: players(true).sumValue(ofProperty: "helpCount"),
            deathCount: players(true).sumValue(ofProperty: "deadCount"),
            kumaPoint: results.sumValue(ofProperty: "kumaPoint")
        )
    }
    
    /// 支給スペシャル回数
    var specialData: [SpecialList] {
        if results.isEmpty { return WeaponInfoSpecial.Id.regular.map({ .init(id: $0, count: nil, percent: nil) }) }
        let results: [WeaponInfoSpecial.Id] = results.compactMap(\.player.specialId)
        return .init(
            WeaponInfoSpecial.Id.regular.map({
                .init(id: $0, count: results.count($0), percent: Double(results.count($0)) / Double(results.count))
            })
        )
    }
    
    /// オオモノ討伐回数
    var bossData: [BossList] {
        if results.isEmpty {
            return CoopEnemyInfo.Id.regular.map({ enemyId in BossList(id: enemyId, player: nil, team: nil, appear: nil)
            })
        }
        let results = results.map({
            (bossCounts: $0.bossCounts, bossKillCounts: $0.bossKillCounts, killCounts: $0.player.bossKillCounts)
        })
        let bossCounts: RealmSwift.List<Int> = results.map(\.bossCounts).sum()
        let bossKillCounts: RealmSwift.List<Int> = results.map(\.bossKillCounts).sum()
        let killCounts: RealmSwift.List<Int?> = results.map(\.killCounts).sum()
        let bossList: [BossList] = CoopEnemyInfo.Id.regular.map({ enemyId in
            let index: Int = CoopEnemyInfo.Id.allCases.firstIndex(of: enemyId) ?? 0
            return BossList(
                id: enemyId,
                player: killCounts[index],
                team: bossKillCounts[index],
                appear: bossCounts[index]
            )
        })
        return .init(bossList)
    }
    
    /// 支給ブキ回数
    var weaponData: [WeaponList] {
        let results: [WeaponInfoMain.Id] = results.flatMap(\.player.weaponList)
        let targetList: [WeaponInfoMain.Id] =
        isRandom ? weaponList.contains(WeaponInfoMain.Id.RandomGold) ? WeaponInfoMain.Id.bear : WeaponInfoMain.Id.regular + .init(rareWeapons) : .init(weaponList)
        return targetList.map({ weaponId in
                .init(
                    id: weaponId,
                    count: results.count(weaponId),
                    percent: Double(results.count(weaponId)) / Double(results.count)
                )
        })
    }
}
