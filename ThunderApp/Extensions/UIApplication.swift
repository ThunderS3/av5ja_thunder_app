//
//  UIApplication.swift
//  ThunderApp
//  
//  Created by devonly on 2024/07/15.
//  Copyright © 2024 Magi. All rights reserved.
//

import Foundation
import SwiftUI

#if canImport(UIKit)
public extension UIApplication {
    /// UIWindow
    var window: UIWindow? {
        UIApplication.shared.connectedScenes.compactMap { $0 as? UIWindowScene }.first?.windows.first
    }
}
#endif
