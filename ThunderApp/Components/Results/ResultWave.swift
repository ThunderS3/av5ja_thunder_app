//
//  ResultWave.swift
//  ThunderApp
//  
//  Created by devonly on 2024/06/15.
//  Copyright © 2024 Magi. All rights reserved.
//

import SwiftUI

struct ResultWave: View {
    let result: RealmCoopResult

    var body: some View {
        VStack(spacing: 2, content: {
            ForEach(result.waves, content: { wave in
                _body(wave: wave)
            })
        })
    }

    private func _body(wave: RealmCoopWave) -> some View {
        HStack(spacing: 0, content: {
            VStack(alignment: .leading, content: {
                VStack(alignment: .leading, content: {
                    Text(wave.waterLevel)
                        .font(.custom(.Splatfont2, size: 14))
                    Text(wave.eventType)
                        .font(.custom(.Splatfont2, size: 14))
                })
                Spacer()
                LazyVGrid(columns: .init(repeating: .init(.fixed(18), spacing: 4), count: 4), content: {
                })
                .frame(maxWidth: 80)
                .padding(.trailing, 8)
                HStack(spacing: 0, content: {
                })
                .font(.custom(.Splatfont2, size: 14))
                .padding(.vertical, 4)
                .padding(.horizontal, 6)
                .frame(height: 39)
            })
        })
    }
}

#Preview {
    ResultWave(result: .preview)
}
