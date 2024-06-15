//
//  ResultPlayer.swift
//  ThunderApp
//
//  Created by devonly on 2024/06/15.
//  Copyright © 2024 Magi. All rights reserved.
//

import SwiftUI
import Thunder

struct ResultPlayer: View {
    let result: RealmCoopResult

    var body: some View {
        ForEach(result.players, content: { player in
            NavigationLinker(destination: {
                EmptyView()
            }, label: {
                _body(player)
            })
        })
    }

    private func _body(_ player: RealmCoopPlayer) -> some View {
        HStack(spacing: 0, content: {
            VStack(alignment: .leading, spacing: 0, content: {
                Text(player.name)
                    .lineLimit(1)
                    .font(.custom(.Splatfont2, size: 14))
                    .padding(.bottom, 2)
                HStack(spacing: 2, content: {
                    if let specialId: WeaponInfoSpecial.Id = player.specialId {
                        SPImage(specialId)
                            .frame(width: 28, height: 28)
                            .background(content: {
                                RoundedRectangle(cornerRadius: 4)
                                    .fill(Color.black.opacity(0.75))
                            })
                    }
                    ForEach(player.weaponList.indices, id: \.self, content: { index in
                        SPImage(player.weaponList[index])
                            .frame(width: 28, height: 28)
                            .background(content: {
                                RoundedRectangle(cornerRadius: 4)
                                    .fill(Color.black.opacity(0.75))
                            })
                    })
                })
            })
            HStack(spacing: 0, content: {
                VStack(alignment: .trailing, spacing: 0, content: {
                })
            })
        })
    }
}

#Preview {
    ResultPlayer(result: .preview)
}
