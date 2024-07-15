//
//  MyPageView.swift
//  Salmonia3+
//
//  Created by devonly on 2024/06/02.
//  Copyright © 2024 Magi. All rights reserved.
//

import SwiftUI
import Raccoon

struct MyPageView: View {
    @EnvironmentObject private var config: ThunderConfig
    
    var body: some View {
        ScrollView(content: {
            LazyVGrid(columns: .init(repeating: .init(.flexible(maximum: 103.2), spacing: 24, alignment: .top), count: 3), spacing: nil, content: {
                Review()
                //                    Network()
                //                    MyAccount()
                History()
                License()
            })
            .padding(.bottom, 8)
            LazyVGrid(
                columns: .init(repeating: .init(.flexible(maximum: 69.13), spacing: 24, alignment: .top), count: 4),
                spacing: 16,
                content: {
                    //                    Battle()
                    //                    Stages()
                    //                    CoopWork()
                    //                    Management()
                    Settings()
                }
            )
        })
    }
}
        //            LazyVGrid(columns: .init(repeating: .init(.flexible(maximum: 69.13)), count: 4), content: {
        //                SignIn()
//                        RemoveAll()
        //            })

#Preview {
    MyPageView()
}
