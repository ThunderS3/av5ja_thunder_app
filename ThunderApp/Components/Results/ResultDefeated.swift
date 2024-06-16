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
    @State private var scale: CGFloat = .zero
    let result: RealmCoopResult
    
    var body: some View {
        LazyVGrid(columns: .init(repeating: .init(.flexible(), spacing: 2), count: 4), spacing: 2, content: {
            ForEach(CoopEnemyInfo.Id.regular.indices, id: \.self, content: { index in
                let enemyId: CoopEnemyInfo.Id = CoopEnemyInfo.Id.regular[index]
                let bossCount: CGFloat = .init(result.bossCounts[index])
                let count: Int = result.player.bossKillCounts[index] ?? 0
                let bossKillCount: CGFloat = .init(result.bossKillCounts[index])
                let bias: CGFloat = bossCount == 0 ? 0 : min(1, bossKillCount / bossCount)
                if bossCount != .zero {
                    _body(enemyId, bossCount: bossCount, bossKillCount: bossKillCount, count: count, bias: bias)
                }
            })
        })
        .onAppear(perform: {
            withAnimation(.easeIn(duration: 0.8), {
                scale = 1.0
            })
        })
        .onDisappear(perform: {
            scale = .zero
        })
    }

    @ViewBuilder
    private func _body(_ enemyId: CoopEnemyInfo.Id, bossCount: CGFloat, bossKillCount: CGFloat, count: Int, bias: CGFloat) -> some View {
        VStack(spacing: 0, content: {
            SPImage(enemyId)
                .scaledToFit()
                .frame(width: 28, height: 28)
                .padding(.top, 4)
                .padding(.bottom, 4)
            GeometryReader(content: { geometry in
                ZStack(alignment: .leading, content: {
                    Rectangle()
                        .fill(SPColor.SP3.SPGray)
                        .frame(width: geometry.size.width, height: 14)
                    Rectangle()
                        .fill(SPColor.SP3.SPOrange)
                        .frame(width: geometry.size.width * bias * scale, height: 14)
                    //                                .animation(.easeIn(duration: 0.8), value: scale)
                })
                .overlay(alignment: .center, content: {
                    Text("\(Int(bossKillCount))(\(count))/\(Int(bossCount))")
                        .font(.custom(.Splatfont2, size: 12))
                })
            })
            .frame(height: 14)
        })
        .background(content: {
            bossCount == bossKillCount ? SPColor.SP3.SPYellow : SPColor.SP3.SPBackground
        })
    }
}

#Preview {
    ResultDefeated(result: .preview())
}
