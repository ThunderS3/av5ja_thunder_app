//
//  ScheduleScale.swift
//  ThunderApp
//  
//  Created by devonly on 2024/07/13.
//  Copyright © 2024 Magi. All rights reserved.
//

import SwiftUI
import Raccoon
import Thunder

struct ScheduleScale: View {
    let schedule: RealmCoopSchedule
    
    var body: some View {
        _body
    }
    
    @ViewBuilder
    private var _body: some View {
        GroupBox(content: {
            VStack(spacing: 4, content: {
                Text(LocalizedType.CoopHistoryScale)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.custom(.Splatfont2, size: 14))
                HStack(content: {
                    ForEach(schedule.results.scales.indices, id: \.self, content: { index in
                        VStack(spacing: 0, content: {
                            switch index {
                            case 0:
                                SPImage(Media.SP3.PNG.UrokoBronze)
                                    .frame(width: 24, height: 24)
                            case 1:
                                SPImage(Media.SP3.PNG.UrokoSilver)
                                    .frame(width: 24, height: 24)
                            case 2:
                                SPImage(Media.SP3.PNG.UrokoGolden)
                                    .frame(width: 24, height: 24)
                            default:
                                EmptyView()
                            }
                            Text(schedule.results.scales[index], format: .number)
                                .font(.custom(.Splatfont2, size: 14))
                        })
                        .padding(.horizontal, 4)
                    })
                })
            })
        })
    }
}

#Preview {
    ScheduleScale(schedule: .preview)
}
