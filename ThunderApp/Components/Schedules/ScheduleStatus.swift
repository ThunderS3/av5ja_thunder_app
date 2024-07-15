//
//  ScheduleStatus.swift
//  ThunderApp
//  
//  Created by devonly on 2024/07/13.
//  Copyright © 2024 Magi. All rights reserved.
//

import SwiftUI
import Thunder

struct ScheduleStatus: View {
    let schedule: RealmCoopSchedule
    
    var body: some View {
        _ScheduleStatus
    }
    
    @ViewBuilder
    private var _ScheduleStatus: some View {
        GroupBox(content: {
            VStack(content: {
                VStack(spacing: 4,content: {
                    Text(LocalizedType.CoopHistoryGradePoint)
                        .font(.custom(.Splatfont2, size: 12.5))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    HStack(content: {
                        Text(schedule.results.maxGradeId)
                            .lineLimit(1)
                        Text(schedule.results.maxGradePoint, format: .number())
                    })
                    .font(.custom(.Splatfont2, size: 14))
                    .foregroundColor(SPColor.SP3.SPOrange)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                })
                .padding(.bottom, 4)
                VStack(spacing: 4, content: {
                    Text(LocalizedType.CoopHistoryAverageClearWaves)
                        .font(.custom(.Splatfont2, size: 12.5))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .lineLimit(1)
                    Text(schedule.results.averageClearedWaves, format: .number(3))
                        .font(.custom(.Splatfont2, size: 14))
                        .foregroundColor(SPColor.SP3.SPOrange)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .lineLimit(1)
                })
            })
        })
    }
}

#Preview {
    ScheduleStatus(schedule: .preview)
}
