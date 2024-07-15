//
//  WaveView.swift
//  ThunderApp
//  
//  Created by devonly on 2024/07/15.
//  Copyright © 2024 Magi. All rights reserved.
//

import SwiftUI
import Raccoon
import Thunder

struct WaveView: View {
    private let wave: RealmCoopWave
    
    init(wave: RealmCoopWave) {
        self.wave = wave
    }
    
    var body: some View {
        HStack(content: {
            VStack(alignment: .leading, content: {
                Text(wave.waterLevel)
                    .font(.custom(.Splatfont2, size: 12))
                Text(wave.eventType)
                    .font(.custom(.Splatfont2, size: 14))
            })
            Spacer()
            VStack(alignment: .trailing, content: {
                HStack(alignment: .top, content: {
                    SPImage(Media.SP3.SVG.GoldIkura)
                        .scaledToFit()
                        .frame(width: 18, height: 18)
                    Text(wave.goldenIkuraNum, format: .number())
                        .font(.custom(.Splatfont2, size: 14))
                })
            })
            .frame(width: 50, height: 36)
            .padding(.horizontal, 4)
            .padding(.vertical, 2)
            .background(content: {
                RoundedRectangle(cornerRadius: 4)
                    .fill(SPColor.SP3.SPBackground)
            })
        })
        .padding(.horizontal, 8)
        .frame(height: 50)
        .frame(maxWidth: .infinity)
        .background(content: {
            wave.isClear ? SPColor.SP3.SPSalmonOrange : SPColor.SP3.SPSalmonOrangeDarker
        })
        .padding(.bottom, 2)
        .listRowInsets(EdgeInsets())
        .listRowSeparator(.hidden)
    }
}

#Preview {
    WaveView(wave: .preview)
}
