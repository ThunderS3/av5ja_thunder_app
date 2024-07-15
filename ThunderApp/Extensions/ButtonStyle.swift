//
//  ButtonStyle.swift
//  ThunderApp
//  
//  Created by devonly on 2024/07/15.
//  Copyright © 2024 Magi. All rights reserved.
//

import Foundation
import Raccoon
import SwiftUI

struct SPButtonStyle: ButtonStyle {
    let icon: Media.SP3.SVG
    let foregroundColor: Color

    func makeBody(configuration: ButtonStyle.Configuration) -> some View {
        VStack(content: {
            SPCircle().scaledToFit().foregroundColor(foregroundColor).overlay(content: {
                SPImage(url: icon.assetURL)
                    .scaledToFit()
                    .padding(8)
            })
            configuration.label
        }).opacity(configuration.isPressed ? 0.7 : 1.0)
    }
}

extension ButtonStyle where Self == SPButtonStyle {
    static func circle(icon: Media.SP3.SVG, foregroundColor: Color) -> SPButtonStyle {
        SPButtonStyle(icon: icon, foregroundColor: foregroundColor)
    }
}
