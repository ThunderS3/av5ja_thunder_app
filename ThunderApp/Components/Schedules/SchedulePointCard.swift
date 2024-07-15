//
//  SchedulePointCard.swift
//  ThunderApp
//  
//  Created by devonly on 2024/07/13.
//  Copyright © 2024 Magi. All rights reserved.
//

import SwiftUI
import Thunder

struct SchedulePointCard: View {
    let pointCard: PointCard
   
    init(schedule: RealmCoopSchedule) {
        self.pointCard = schedule.pointCard
    }
    
    var body: some View {
        _body
    }
    
    @ViewBuilder
    private var _body: some View {
        GroupBox(content: {
            VStack(alignment: .trailing, content: {
                VStack(spacing: 4, content: {
                    Text(LocalizedType.CoopHistoryTotalPoint)
                        .font(.custom(.Splatfont2, size: 12.5))
                        .frame(
                        maxWidth: .infinity,
                        alignment: .leading
                    )
                    Text(pointCard.kumaPoint, format: .number())
                        .font(.custom(.Splatfont2, size: 14))
                        .frame(
                        maxWidth: .infinity,
                        alignment: .trailing
                    )
                })
                .padding(8)
                .background(content: {
                    RoundedRectangle(cornerRadius: 8, style: .continuous)
                        .fill(Color.black.opacity(0.7))
                })
                .foregroundColor(SPColor.SP3.SPYellow)
                .padding(.bottom, 4)
                Label(bundle: .CoopHistoryPlayCount, value: pointCard.shiftWorked)
                Label(bundle: .CoopHistoryGoldenDeliverCount, value: pointCard.goldenIkuraNum)
                Label(bundle: .CoopHistoryDeliverCount, value: pointCard.ikuraNum)
                Label(bundle: .CoopHistoryDefeatBossCount, value: pointCard.kingKillCount)
                Label(bundle: .CoopHistoryDefeatedEnemies, value: pointCard.bossKillCount)
                Label(bundle: .CoopHistoryRescueCount, value: pointCard.helpCount)
                Label(bundle: .CoopHistoryDeathCount, value: pointCard.deathCount)
            })
            .foregroundColor(Color.black)
        })
        .backgroundColorStyle(SPColor.SP2.SPYellow)
    }
    
    private struct Label: View {
        let bundle: LocalizedType
        let value: Int?
        
        var body: some View {
            VStack(spacing: 4, content: {
                Text(bundle)
                    .font(.custom(.Splatfont2, size: 12.5))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .lineLimit(1)
                Text(value, format: .number())
                    .font(.custom(.Splatfont2, size: 14))
                    .frame(maxWidth: .infinity, alignment: .trailing)
                Divider()
            })
        }
    }
}

#Preview {
    SchedulePointCard(schedule: .preview)
}
