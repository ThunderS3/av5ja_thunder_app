//
//  RealmCoopPlayer.swift
//  Salmonia3+
//
//  Created by devonly on 2023/12/05
//  Copyright © 2023 Magi Corporation. All rights reserved.
//

import Foundation
import RealmSwift
import Thunder

final class RealmCoopPlayer: Object, Identifiable, Codable {
    @Persisted(primaryKey: true) var id: String
    @Persisted(indexed: true) var nplnUserId: String
    @Persisted var name: String
    @Persisted var byname: String
    @Persisted var nameId: String
    @Persisted var isMyself: Bool
    @Persisted var deadCount: Int
    @Persisted var helpCount: Int
    @Persisted var goldenIkuraNum: Int
    @Persisted var ikuraNum: Int
    @Persisted var goldenIkuraAssistNum: Int
    @Persisted var specialId: WeaponInfoSpecial.Id?
    @Persisted var species: Species
    @Persisted var bossKillCountsTotal: Int
    @Persisted var bossKillCounts: List<Int?>
    @Persisted var specialCounts: List<Int>
    @Persisted var badges: List<BadgeInfo.Id?>
    @Persisted var textColor: List<Decimal128>
    @Persisted var background: NamePlateBgInfo.Id
    @Persisted var weaponList: List<WeaponInfoMain.Id>
    @Persisted var uniform: CoopSkinInfo.Id
    @Persisted(originProperty: "players") private var link: LinkingObjects<RealmCoopResult>

    override init() { super.init() }

//    convenience init(result: CoopHistoryDetailQuery.MemberResult) {
//        self.init()
//        self.id = result.hash
//        self.nplnUserId = result.nplnUserId
//        self.name = result.name
//        self.byname = result.byname
//        self.nameId = result.nameId
//        self.isMyself = result.isMyself
//        self.deadCount = result.deadCount
//        self.helpCount = result.helpCount
//        self.goldenIkuraNum = result.goldenIkuraNum
//        self.ikuraNum = result.ikuraNum
//        self.goldenIkuraAssistNum = result.goldenIkuraAssistNum
//        self.specialId = result.specialId
//        self.species = result.species
//        self.bossKillCounts = .init(contentsOf: result.bossKillCounts)
//        self.bossKillCountsTotal = result.bossKillCountsTotal
//        self.badges = .init(contentsOf: result.nameplate.badges)
//        let textColor: TextColor = result.nameplate.background.textColor
//        self.textColor = .init(
//            contentsOf: [textColor.r, textColor.g, textColor.b, textColor.a].map({ .init(value: $0) })
//        )
//        self.background = result.nameplate.background.id
//        self.weaponList = .init(contentsOf: result.weaponList)
//        self.uniform = result.uniform
//        self.specialCounts = .init(contentsOf: result.specialCounts)
//    }

    private enum CodingKeys: String, CodingKey {
        case id
        case nplnUserId
        case name
        case byname
        case nameId
        case isMyself
        case deadCount
        case helpCount
        case goldenIkuraNum
        case ikuraNum
        case goldenIkuraAssistNum
        case specialId
        case species
        case bossKillCounts
        case bossKillCountsTotal
        case specialCounts
        case badges
        case textColor
        case background
        case weaponList
        case uniform
    }

//    init(from decoder: Decoder) throws {}

    func encode(to encoder: Encoder) throws {
        var contaienr = encoder.container(keyedBy: CodingKeys.self)
        try contaienr.encode(id, forKey: .id)
        try contaienr.encode(nplnUserId, forKey: .nplnUserId)
        try contaienr.encode(name, forKey: .name)
        try contaienr.encode(byname, forKey: .byname)
        try contaienr.encode(nameId, forKey: .nameId)
        try contaienr.encode(isMyself, forKey: .isMyself)
        try contaienr.encode(deadCount, forKey: .deadCount)
        try contaienr.encode(helpCount, forKey: .helpCount)
        try contaienr.encode(goldenIkuraNum, forKey: .goldenIkuraNum)
        try contaienr.encode(ikuraNum, forKey: .ikuraNum)
        try contaienr.encode(goldenIkuraAssistNum, forKey: .goldenIkuraAssistNum)
        try contaienr.encode(specialId, forKey: .specialId)
        try contaienr.encode(species, forKey: .species)
        try contaienr.encode(bossKillCounts, forKey: .bossKillCounts)
        try contaienr.encode(bossKillCountsTotal, forKey: .bossKillCountsTotal)
        try contaienr.encode(specialCounts, forKey: .specialCounts)
        try contaienr.encode(badges, forKey: .badges)
        try contaienr.encode(textColor, forKey: .textColor)
        try contaienr.encode(background, forKey: .background)
        try contaienr.encode(weaponList, forKey: .weaponList)
        try contaienr.encode(uniform, forKey: .uniform)
    }
}

// extension CoopHistoryDetailQuery.MemberResult { var object: RealmCoopPlayer { .init(result: self) } }
//
// extension RealmCoopPlayer {
//    var result: RealmCoopResult { link.first ?? .preview(isClear: true) }
//
//    static func preview(specialId: WeaponInfoSpecial.Id, specialCounts: [Int]) -> RealmCoopPlayer {
//        let player: RealmCoopPlayer = .init()
//        let uuid: UUID = .init()
//        player.id = uuid.uuidString
//        player.nplnUserId = ""
//        player.name = String(uuid.uuidString.prefix(10))
//        player.byname = ""
//        player.nameId = ""
//        player.isMyself = true
//        player.deadCount = Int.random(in: 0...20)
//        player.helpCount = Int.random(in: 0...20)
//        player.goldenIkuraNum = Int.random(in: 0...200)
//        player.ikuraNum = Int.random(in: 0...2_000)
//        player.goldenIkuraAssistNum = Int.random(in: 0...100)
//        player.specialId = specialId
//        player.bossKillCounts = .init(contentsOf: Array(repeating: 0, count: 14).map({ _ in Int.random(in: 0...3) }))
//        player.bossKillCountsTotal = Int.random(in: 0...30)
//        player.specialCounts = .init(contentsOf: specialCounts)
//        player.badges = .init(contentsOf: Array(repeating: nil, count: 3))
//        player.textColor = .init(contentsOf: Array(repeating: 1, count: 4))
//        player.background = .NplCatalogSeason01Lv01
//        player.weaponList = .init(
//            contentsOf: Array(repeating: 0, count: 4).map({ _ in
//                WeaponInfoMain.Id.allCases.randomElement() ?? .SlosherBear
//            })
//        )
//        player.uniform = .COP001
//        return player
//    }
// }
