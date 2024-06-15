//
//  ScheduleView.swift
//  ThunderApp
//  
//  Created by devonly on 2024/06/14.
//  Copyright © 2024 Magi. All rights reserved.
//

import SwiftUI
import Thunder

struct ScheduleView: View {
    let schedule: RealmCoopSchedule

    var body: some View {
        NavigationLinker(destination: {
            _body
        }, label: {
            _body
        })
        .listRowInsets(EdgeInsets())
        .listRowSeparator(.hidden)
    }

    private var _body: some View {
        HStack(spacing: 0, content: {
            SPImage(schedule.stageId)
                .scaledToFill()
                .frame(width: 136, height: 64)
                .clipped()
                .overlay(alignment: .topLeading, content: {
                })
            Rectangle()
                .overlay(alignment: .topLeading, content: {
                })
                .overlay(alignment: .trailing, content: {
                    HStack(content: {
                        ForEach(schedule.weaponList.indices, id: \.self, content: { index in
                            SPImage(schedule.weaponList[index])
                                .frame(width: 36, height: 36)
                        })
                    })
                    .padding(.horizontal, 6)
                    .background(content: {
                        Capsule().fill(.black)
                    })
                    .padding(.bottom, 4)
                    .padding(.trailing, 4)
                })
                .foregroundColor(schedule.backgroundColor)
        })
        .padding(.bottom, 2)
    }
}

extension RealmCoopSchedule {
    fileprivate var backgroundColor: Color {
        switch (isBigRun, !results.isEmpty) {
        case (true, true):
            return SPColor.SP3.SPBigRun
        case (true, false):
            return SPColor.SP3.SPBigRun
        case (false, true):
            return SPColor.SP3.SPSalmonOrange
        case (false, false):
            return SPColor.SP3.SPSalmonOrangeDarker
        }
    }
}

#Preview {
    ScheduleView(schedule: .preview)
}
