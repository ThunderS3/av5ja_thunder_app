//
//  ResultDefeated.swift
//  ThunderApp
//  
//  Created by devonly on 2024/06/15.
//  Copyright © 2024 Magi. All rights reserved.
//

import SwiftUI
import Thunder

struct ResultDefeated: View {
    let result: RealmCoopResult

    var body: some View {
        LazyVGrid(columns: .init(repeating: .init(.flexible(), spacing: 2), count: 4), content: {
            ForEach(CoopEnemyInfo.Id.regular.indices, id: \.self, content: { index in
                let enemyId: CoopEnemyInfo.Id = CoopEnemyInfo.Id.regular[index]
                let bossCount: CGFloat = .init(result.bossCounts[index])
//                let count: Int = result.player.bossKillCounts[index] ?? 0
                let bossKillCount: CGFloat = .init(result.bossKillCounts[index])
                let bias: CGFloat = bossCount == 0 ? 0 : min(1, bossKillCount / bossCount)
                VStack(content: {
                    SPImage(enemyId)
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                        .padding(.top, 4)
                })
            })
        })
    }
}

#Preview {
    ResultDefeated(result: .preview)
}
