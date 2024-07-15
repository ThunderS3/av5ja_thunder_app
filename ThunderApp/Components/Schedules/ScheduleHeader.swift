//
//  ScheduleHeader.swift
//  ThunderApp
//  
//  Created by devonly on 2024/07/13.
//  Copyright © 2024 Magi. All rights reserved.
//

import SwiftUI
import Raccoon
import Thunder
import RealmSwift

struct ScheduleHeader: View {
    @State private var selection: Int = 0
    @State private var bossList: [BossList] = []
    @State private var specialList: [SpecialList] = []
    @State private var weaponList: [WeaponList] = []
    let schedule: RealmCoopSchedule
    
    var body: some View {
        _body
            .onAppear(perform: {
                self.bossList = .init(schedule.bossData)
                self.specialList = .init(schedule.specialData)
                self.weaponList = .init(schedule.weaponData)
            })
    }
    
    @ViewBuilder
    private var _body: some View {
        VStack(content: {
            GroupBox(content: {
                TabView(selection: $selection, content:  {
                    _HeaderMain
                        .tag(0)
                    _HeaderSpecial
                        .tag(1)
                    _HeaderEnemy
                        .tag(2)
                })
            })
        })
        .frame(height: 170)
        .tabViewStyle(.page(indexDisplayMode: .never))
        .gridCellColumns(2)
        .gridCellUnsizedAxes(.horizontal)
        HStack(content: {
            ForEach([0, 1, 2], id: \.self, content: { index in
                Rectangle()
                    .fill(index == selection ? SPColor.SP3.SPYellow : SPColor.SP3.SPBigRun)
                    .frame(width: 80, height: 8)
                    .onTapGesture(perform: {
                        withAnimation(.default) {
                            selection = index
                        }
                    })
            })
        })
    }
    
    @ViewBuilder
    private var _HeaderMain: some View {
        switch schedule.isRandom {
        case true:
            NavigationLink(destination: {
                WeaponListView(weaponList: weaponList)
            }, label: {
                VStack(content: {
                    _RandomWeaponList
                    _HeaderStatus
                })
            })
        case false:
            VStack(content: {
                _RegularWeaponList
                _HeaderStatus
            })
        }
    }
    
    @ViewBuilder
    private var _HeaderStatus: some View {
        VStack(content: {
            let players: RealmSwift.List<RealmCoopPlayer> = schedule.players(true)
            HStack(content: {
                HStack(content: {
                    SPImage(Media.SP2.PNG.GolenIkura)
                        .scaledToFit()
                        .frame(height: 14)
                    Text(players.goldenIkuraNum.avg, format: .number(2))
                        .font(.custom(.Splatfont2, size: 16))
                })
                HStack(content: {
                    SPImage(Media.SP2.PNG.Ikura)
                        .scaledToFit()
                        .frame(height: 14)
                    Text(players.ikuraNum.avg, format: .number(2))
                        .font(.custom(.Splatfont2, size: 16))
                })
                HStack(content: {
                    SPImage(Media.SP3.SVG.HelpedSquid)
                        .scaledToFit()
                        .frame(height: 14)
                    Text(players.helpCount.avg, format: .number(2))
                        .font(.custom(.Splatfont2, size: 16))
                })
            })
            .padding(.horizontal)
            .padding(.vertical, 8)
            .foregroundColor(SPColor.SP3.SPAzure)
            .background(content: {
                RoundedRectangle(cornerRadius: 24, style: .circular)
                    .fill(.black.opacity(0.8))
            })
        })
        .frame(maxWidth: .infinity)
    }
    
    @ViewBuilder
    private var _HeaderSpecial: some View {
        LazyVGrid(columns: .init(repeating: .init(.flexible()), count: 3), content: {
            ForEach(specialList, content: { entry in
                HStack(content: {
                    SPImage(entry.id).frame(width: 28, height: 28)
                    Spacer()
                    Text(entry.percent, format: .percent(3))
                })
            })
        })
        .font(.custom(.Splatfont2, size: 16))
        .padding(.horizontal, 8)
    }
    
    @ViewBuilder
    private var _HeaderEnemy: some View {
        LazyVGrid(columns: .init(repeating: .init(.flexible()), count: 4), spacing: 8, content: {
            ForEach(bossList, content: { value in
                HStack(content: {
                    SPImage(value.id).frame(width: 28, height: 28)
                    Spacer()
                    Text(value.player, format: .number())
                })
            })
        })
        .font(.custom(.Splatfont2, size: 16))
        .padding(.horizontal, 8)
    }
    
    @ViewBuilder
    private var _RandomWeaponList: some View {
        VStack(spacing: 4, content: {
            HStack(content: {
                ForEach(schedule.weaponList.indices, id: \.self, content: { index in
                    let weaponId: WeaponInfoMain.Id = schedule.weaponList[index]
                    SPImage(weaponId)
                        .frame(width: 48, height: 48)
                        .background(content: {
                            Circle().fill(.black)
                        })
                })
            })
            switch weaponList.isCompleted {
            case true:
                Text(LocalizedType.CoopHistoryRandomComplete)
                    .font(.custom(.Splatfont1, size: 20))
                    .foregroundColor(SPColor.SP3.SPBigRun)
            case false:
                Text("\(weaponList.suppliedCount)/\(weaponList.count)")
                    .font(.custom(.Splatfont1, size: 20))
                    .foregroundColor(SPColor.SP3.SPAzure)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(content: {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(SPColor.SP3.SPBackground)
                    })
            }
        })
    }
    
    @ViewBuilder
    private var _RegularWeaponList: some View {
        HStack(content: {
            ForEach(weaponList, content: { weapon in
                VStack(spacing: 0, content: {
                    SPImage(weapon.id)
                        .frame(width: 48, height: 48)
                        .background(content: {
                            Circle().fill(.black)
                        })
                    Text(weapon.percent, format: .percent(2))
                        .font(.custom(.Splatfont2, size: 14))
                })
            })
        })
    }
}

#Preview {
    ScheduleHeader(schedule: .preview)
}
