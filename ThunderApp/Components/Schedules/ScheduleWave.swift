//
//  ScheduleWave.swift
//  ThunderApp
//  
//  Created by devonly on 2024/07/13.
//  Copyright © 2024 Magi. All rights reserved.
//

import SwiftUI
import Thunder

struct ScheduleWave: View {
    let schedule: RealmCoopSchedule
    
    var body: some View {
        _ScheduleWave
    }
    
    @ViewBuilder
    private var _ScheduleWave: some View {
        GroupBox(content: {
            VStack(spacing: 0, content: {
                Text(LocalizedType.CoopHistoryEventClearRatio)
                    .font(.custom(.Splatfont2, size: 14))
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(schedule.results.clearRatio, format: .number(3))
                    .font(.custom(.Splatfont2, size: 16))
                    .foregroundColor(SPColor.SP3.SPOrange)
                    .frame(maxWidth: .infinity, alignment: .trailing)
            })
        })
    }
}

#Preview {
    ScheduleWave(schedule: .preview)
}
