//
//  License.swift
//  ThunderApp
//  
//  Created by devonly on 2024/07/15.
//  Copyright © 2024 Magi. All rights reserved.
//

import SwiftUI
import LicenseList
import Thunder

struct License: View {
    @State private var isPresented = false
    
    var body: some View {
        NavigationLink(destination: {
            LicenseListView()
                .navigationTitle(Text(LocalizedType.CommonLicense))
        }, label: {
            Text(LocalizedType.SettingsAcknowledgements)
                .font(.custom(.Splatfont2, size: 12))
                .lineLimit(1)
        })
        .buttonStyle(.circle(icon: .Gesotown, foregroundColor: .black))
    }
}

#Preview {
    License()
}
