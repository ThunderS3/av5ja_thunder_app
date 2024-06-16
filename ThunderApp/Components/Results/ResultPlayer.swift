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
    @Environment(\.visible) var visible
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
            _common(player)
            _status(player)
        })
        .padding(.vertical, 2)
        .padding(.horizontal, 4)
        .background(content: {
            SPColor.SP2.SPOrange
        })
    }
    
    private func _common(_ player: RealmCoopPlayer) -> some View {
        VStack(alignment: .leading, spacing: 0, content: {
            Text(visible.wrappedValue ? player.name : "-")
                .lineLimit(1)
                .font(.custom(.Splatfont2, size: 14))
                .padding(.bottom, 2)
            HStack(spacing: 2, content: {
                ForEach(player.weaponList.indices, id: \.self, content: { index in
                    SPImage(player.weaponList[index])
                        .frame(width: 28, height: 28)
                        .background(content: {
                            Circle()
                                .fill(Color.black)
                        })
                })
                if let specialId: WeaponInfoSpecial.Id = player.specialId {
                    SPImage(specialId)
                        .frame(width: 28, height: 28)
                        .background(content: {
                            RoundedRectangle(cornerRadius: 4)
                                .fill(Color.black)
                        })
                }
            })
            .padding(.bottom, 2)
            HStack(spacing: 4, content: {
                Text(LocalizedType.CoopHistoryDefeatedCount)
                Text(player.bossKillCountsTotal, format: .number())
            })
            .font(.custom(.Splatfont2, size: 12))
            .foregroundColor(SPColor.SP2.SPYellow)
        })
    }
    
    private func _status(_ player: RealmCoopPlayer) -> some View {
        HStack(spacing: 8, content: {
            VStack(alignment: .trailing, spacing: 4, content: {
                HStack(spacing: 0, content: {
                    GoldenIkura
                        .frame(width: 40, height: 20, alignment: .leading)
                    Text(player.goldenIkuraNum, format: .number())
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .font(.custom(.Splatfont2, size: 14))
                })
                .frame(width: 75.32, height: 22)
                .background()
                HStack(spacing: 0, content: {
                    Rescue(player.species)
                        .frame(width: 40, height: 20, alignment: .leading)
                    Text(player.helpCount, format: .number())
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .font(.custom(.Splatfont2, size: 14))
                })
                .frame(width: 75.32, height: 22)
                .background()
            })
            VStack(alignment: .trailing, spacing: 4, content: {
                HStack(spacing: 0, content: {
                    Ikura
                        .frame(width: 40, height: 20, alignment: .leading)
                    Text(player.ikuraNum, format: .number())
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .font(.custom(.Splatfont2, size: 14))
                })
                .frame(width: 75.32, height: 22)
                .background()
                HStack(spacing: 0, content: {
                    Death(player.species)
                        .frame(width: 40, height: 20, alignment: .leading)
                    Text(player.deadCount, format: .number())
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .font(.custom(.Splatfont2, size: 14))
                })
                .frame(width: 75.32, height: 22)
                .background()
            })
        })
        .foregroundColor(SPColor.SP2.SPWhite)
        .frame(maxWidth: .infinity, alignment: .trailing)
    }
}

extension View {
    func background() -> some View {
        padding(.vertical, 1)
            .padding(.leading, 4)
            .padding(.trailing, 8)
            .background(content: {
                Capsule()
                    .fill(.black.opacity(0.75))
            })
    }
}

#Preview {
    ResultPlayer(result: .preview())
        .environment(\.visible, .constant(true))
}
