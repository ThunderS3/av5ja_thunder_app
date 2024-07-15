//
//  ThunderConfig.swift
//  ThunderApp
//  
//  Created by devonly on 2024/06/12.
//  Copyright © 2024 Magi. All rights reserved.
//

import Foundation
import SwiftUI

internal class ThunderConfig: ObservableObject {
    private init() {}
    
    static let `default`: ThunderConfig = .init()

#if targetEnvironment(simulator)
    @AppStorage("APP_FIRST_LAUNCH") var isFirstLaunch: Bool = false
#else
    @AppStorage("APP_FIRST_LAUNCH") var isFirstLaunch: Bool = true
#endif
    @AppStorage("APP_PREFERRED_COLOR_SCHEME") var usePreferredColorScheme = true
    @AppStorage("APP_SYSTEM_COLOR_SCHEME") var useSystemColorScheme = true
    @AppStorage("APP_RESULTS_GAMING_MODE") var useGamingModeResults = true
    
    var preferredColorScheme: UIUserInterfaceStyle {
        useSystemColorScheme
        ? UITraitCollection.current.userInterfaceStyle
        : (usePreferredColorScheme ? .dark : .light)
    }
}
