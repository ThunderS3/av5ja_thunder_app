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
    
    /// UIWindow
    var firstWindow: UIWindow? {
        UIApplication.shared.foregroundScene?.windows.first
    }
    
    /// UIWindowScene
    var foregroundScene: UIWindowScene? {
        UIApplication.shared.connectedScenes.compactMap { $0 as? UIWindowScene }.first(where: { $0.activationState == .foregroundActive })
    }
    
    /// 現在表示されている最も上位のView
    var presentedViewController: UIViewController? {
        guard let window: UIWindow = firstWindow
        else {
            return nil
        }
        // 秘密のおまじない
        window.makeKeyAndVisible()

        guard let rootViewController = window.rootViewController
        else {
            return nil
        }

        var topViewController: UIViewController? = rootViewController
        while let newTopViewController: UIViewController = topViewController?.presentedViewController {
            topViewController = newTopViewController
        }
        return topViewController
    }
}
#endif
