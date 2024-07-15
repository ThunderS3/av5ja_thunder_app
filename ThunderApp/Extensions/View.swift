//
//  View.swift
//  ThunderApp
//
//  Created by devonly on 2024/07/15.
//  Copyright © 2024 Magi. All rights reserved.
//

import Foundation
import SwiftUI

extension View {
    @ViewBuilder
    func overrideUserInterfaceStyle(_ theme: UIUserInterfaceStyle, _ scenePhase: ScenePhase) -> some View {
        self.onChange(of: scenePhase, perform: { scene in
            if scene == .active {
                UIApplication.shared.window?.overrideUserInterfaceStyle = theme
            }
        })
        .onChange(of: theme, perform: { newValue in
            UIApplication.shared.window?.overrideUserInterfaceStyle = newValue
        })
        .onAppear(perform: {
            UIApplication.shared.window?.overrideUserInterfaceStyle = theme
        })
    }
}
