//
//  WavesView.swift
//  ThunderApp
//  
//  Created by devonly on 2024/07/15.
//  Copyright © 2024 Magi. All rights reserved.
//

import SwiftUI
import RealmSwift
import Thunder

struct WavesView: View {
    @ObservedResults(RealmCoopWave.self, sortDescriptor: SortDescriptor(keyPath: "goldenIkuraNum", ascending: false)) var waves
    
    var body: some View {
        List(content: {
            ForEach(waves.filter({ $0.goldenIkuraNum != nil }), content: { wave in
                WaveView(wave: wave)
            })
        })
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(Text(LocalizedType.CoopHistoryWaveResult))
        .listStyle(.plain)
    }
}

#Preview {
    WavesView()
}
