//
//  ScheduleDetailView.swift
//  ThunderApp
//  
//  Created by devonly on 2024/07/13.
//  Copyright © 2024 Magi. All rights reserved.
//

import SwiftUI
import Thunder

struct ScheduleDetailView: View {
    let schedule: RealmCoopSchedule
    
    var body: some View {
        ScrollView(content: {
            _body
        })
        .navigationTitle(Text(LocalizedType.StageScheduleTitle))
    }
    
    private var _body: some View {
        Grid(alignment: .top, content: {
            ScheduleHeader(schedule: schedule)
            Divider()
                .gridCellUnsizedAxes(.horizontal)
            GridRow(content: {
                VStack(content: {
                    ScheduleStatus(schedule: schedule)
                    NavigationLink(destination: {
                        ScheduleWaveView(schedule: schedule)
                    }, label: {
                        ScheduleWave(schedule: schedule)
                    })
                    .buttonStyle(.plain)
                    ScheduleScale(schedule: schedule)
                })
                SchedulePointCard(schedule: schedule)
            })
        })
    }
}

#Preview {
    ScheduleDetailView(schedule: .preview)
}
