//
//  ResultHeader.swift
//  ThunderApp
//  
//  Created by devonly on 2024/06/15.
//  Copyright © 2024 Magi. All rights reserved.
//

import SwiftUI
import Thunder

struct ResultHeader: View {
    let result: RealmCoopResult

    var body: some View {
        SPImage(result.stageId)
            .scaledToFill()
            .frame(maxWidth: .infinity)
            .frame(height: 75)
            .clipped()
            .overlay(alignment: .topLeading, content: {
                Text(result.playTime, format: .dateTime)
                    .font(.custom(.Splatfont2, size: 14))
                    .foregroundColor(.white)
                    .padding(.horizontal, 4)
                    .background(content: {
//                        Color.black.opacity(0.75)
                    })
            })
            .overlay(alignment: .topTrailing, content: {
                Text(result.stageId)
                    .font(.custom(.Splatfont2, size: 14))
                    .foregroundColor(.white)
                    .padding(.horizontal, 4)
                    .background(content: {
//                        Color.black.opacity(0.75)
                    })
            })
            .overlay(alignment: .center, content: {
                Text(result.isClear ? LocalizedType.CoopHistoryClear : LocalizedType.CoopHistoryFailure)
                    .font(.custom(.Splatfont1, size: 24))
                    .foregroundColor(result.isClear ? SPColor.SP2.SPGreen : SPColor.SP2.SPOrange)
            })
    }
}

#Preview {
    ResultHeader(result: .preview)
}
