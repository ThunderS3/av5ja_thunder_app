//
//  CoopWorkView.swift
//  ThunderApp
//
//  Created by devonly on 2024/07/15.
//  Copyright © 2024 Magi. All rights reserved.
//

import SwiftUI
import RealmSwift
import Thunder

struct CoopWorkView: View {
    @ObservedResults(RealmCoopEnemy.self, sortDescriptor: SortDescriptor(keyPath: "enemyId", ascending: true)) private var results
    
    var body: some View {
        NavigationView(content: {
            ScrollView(content: {
                _body
            })
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle(Text(LocalizedType.CoopHistoryEnemy))
        })
    }
    
    private var _body: some View {
        LazyVGrid(columns: .init(repeating: .init(.flexible(maximum: 140)), count: 3), content: {
            ForEach(results, content: { result in
                GroupBox(content: {
                    VStack(content: {
                        SPImage(result.enemyId)
                            .scaledToFit()
                            .frame(height: 60)
                        Group(content: {
                            Text(result.enemyId)
                                .font(.custom(.Splatfont2, size: 12))
                                .lineLimit(1)
                            Text(result.count ?? 0, format: .number)
                                .font(.custom(.Splatfont2, size: 14))
                                .foregroundColor(.secondary)
                        })
                    })
                    .frame(maxWidth: .infinity)
                })
            })
        })
    }
}

#Preview {
    CoopWorkView()
}
