//
//  SignIn.swift
//  ThunderApp
//  
//  Created by devonly on 2024/06/16.
//  Copyright © 2024 Magi. All rights reserved.
//

import SwiftUI

struct SignIn: View {
    @EnvironmentObject private var config: ThunderConfig
    
    var body: some View {
        Button(action: {
            config.isFirstLaunch.toggle()
        }, label: {
            Text("Sign out")
                .font(.custom(.Splatfont2, size: 16))
        })
    }
}

#Preview {
    SignIn()
}
