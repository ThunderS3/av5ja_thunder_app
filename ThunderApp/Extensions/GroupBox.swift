//
//  GroupBox.swift
//  ThunderApp
//  
//  Created by devonly on 2024/07/14.
//  Copyright © 2024 Magi. All rights reserved.
//

import Foundation
import SwiftUI

extension GroupBox {
    @ViewBuilder func backgroundColorStyle(_ color: Color) -> some View {
        if #available(iOS 16.4, *) { backgroundStyle(color) }
    }
}

private struct ColoredGroupBox: GroupBoxStyle {
    func makeBody(configuration: Configuration) -> some View { configuration.label.background() }
}
