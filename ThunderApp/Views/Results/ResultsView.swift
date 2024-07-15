//
//  ResultsView.swift
//  Salmonia3+
//  
//  Created by devonly on 2024/06/02.
//  Copyright © 2024 Magi. All rights reserved.
//

import SwiftUI
import RealmSwift
import Firebolt
import Thunder

struct ResultsView: View {
    @Environment(\.manager) private var manager: RealmManager
    @ObservedResults(RealmCoopSchedule.self) var schedules

    var body: some View {
        NavigationView(content: {
            _body
        })
    }

    private var _body: some View {
        List(content: {
            ForEach(schedules, content: { schedule in
                if !schedule.results.isEmpty {
                    ScheduleView(schedule: schedule)
                    ForEach(schedule.results.sorted(byKeyPath: "playTime", ascending: false), content: { result in
                        ResultView(result: result)
                    })
                }
            })
        })
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
        .background(content: {
            BackgroundWave()
        })
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(Text(LocalizedType.CoopHistoryHistory))
        .refreshable(action: {
            try await manager.refresh()
        })
    }
}

#Preview {
    ResultsView()
}
