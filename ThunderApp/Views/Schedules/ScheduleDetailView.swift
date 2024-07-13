//
//  ScheduleDetailView.swift
//  ThunderApp
//  
//  Created by devonly on 2024/07/13.
//  Copyright © 2024 Magi. All rights reserved.
//

import SwiftUI

struct ScheduleDetailView: View {
    let schedule: RealmCoopSchedule
    
    var body: some View {
        ScrollView(content: {
            _body
        })
    }
    
    private var _body: some View {
        GridRow(alignment: .top, content: {
            ScheduleHeader()
            Divider()
                .gridCellUnsizedAxes(.horizontal)
            GridRow(content: {
                ScheduleStatus(schedule: schedule)
                NavigationLink(destination: {
                    ScheduleWaveView(schedule: schedule)
                }, label: {
                    ScheduleWave(schedule: schedule)
                })
                .buttonStyle(.plain)
                ScheduleScale(schedule: schedule)
            })
        })
    }
}

#Preview {
    ScheduleDetailView(schedule: .preview)
}
