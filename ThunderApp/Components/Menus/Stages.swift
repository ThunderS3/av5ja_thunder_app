//
//  Stages.swift
//  ThunderApp
//
//  Created by devonly on 2024/07/15.
//  Copyright © 2024 Magi. All rights reserved.
//

import SwiftUI
import RealmSwift
import Thunder


struct Stages: View {
    @ObservedResults(RealmCoopResult.self) var results
    @State private var isPresented = false
    
    var body: some View {
        Button(action: {
            isPresented.toggle()
        }, label: {
            Text(LocalizedType.RecordStageRecordAppName)
                .font(.custom(.Splatfont2, size: 12))
                .lineLimit(1)
        })
        .disabled(results.isEmpty)
        .buttonStyle(.circle(icon: .Stage, foregroundColor: SPColor.SP3.SPPurple))
        .sheet(isPresented: $isPresented, content: {
            StageView()
        })
    }
}

#Preview {
    Stages()
}
