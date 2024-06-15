//
//  ResultJob.swift
//  ThunderApp
//  
//  Created by devonly on 2024/06/15.
//  Copyright © 2024 Magi. All rights reserved.
//

import SwiftUI
import Thunder

struct ResultJob: View {
    let result: RealmCoopResult

    var body: some View {
        VStack(alignment: .leading, spacing: 4, content: {
            Text(LocalizedType.CoopHistoryJobPoint)
            HStack(content: {
                Spacer()
                VStack(spacing: 4, content: {
                    Text(LocalizedType.CoopHistoryScore)
                        .foregroundStyle(SPColor.SP2.SPYellow)
                        .font(.custom(.Splatfont2, size: 12))
                    Text(result.jobScore ?? 0, format: .number)
                })
                Text("x")
                VStack(spacing: 4, content: {
                    Text(LocalizedType.CoopHistoryScore)
                        .foregroundStyle(SPColor.SP2.SPYellow)
                        .font(.custom(.Splatfont2, size: 12))
                    Text(result.jobRate?.doubleValue ?? 0, format: .number)
                })
                Text("+")
                VStack(spacing: 4, content: {
                    Text(LocalizedType.CoopHistoryScore)
                        .foregroundStyle(SPColor.SP2.SPYellow)
                        .font(.custom(.Splatfont2, size: 12))
                    Text(result.jobBonus ?? 0, format: .number)
                })
                Text("=")
                HStack(spacing: 4, content: {
                    Text(result.kumaPoint ?? 0, format: .number)
                    Text(LocalizedType.RecordTotalTurfPoint)
                })
            })
        })
        .font(.custom(.Splatfont2, size: 14))
    }
}

#Preview {
    ResultJob(result: .preview)
}
