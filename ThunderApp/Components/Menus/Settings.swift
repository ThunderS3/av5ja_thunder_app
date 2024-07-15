//
//  Settings.swift
//  ThunderApp
//
//  Created by devonly on 2024/07/15.
//  Copyright © 2024 Magi. All rights reserved.
//

import SwiftUI
import Thunder

struct Settings: View {
    var body: some View {
        NavigationLink(
            destination: SettingsView(),
            label: {
                Text(LocalizedType.SettingsTitle)
                    .font(.custom(.Splatfont2, size: 12))
                    .lineLimit(1)
            })
        .buttonStyle(.circle(icon: .Settings, foregroundColor: SPColor.SP3.SPGray))
    }
}

#Preview {
    Settings()
}
