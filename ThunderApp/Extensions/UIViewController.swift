//
//  UIViewController.swift
//  ThunderApp
//  
//  Created by devonly on 2024/07/15.
//  Copyright © 2024 Magi. All rights reserved.
//

import Foundation
#if canImport(UIKit)
import UIKit

public extension UIViewController {
    func popover(_ viewControllerToPresent: UIActivityViewController, animated: Bool, completion: (() -> Void)? = nil) {
        if UIDevice.current.userInterfaceIdiom == .pad {
            if let popover = viewControllerToPresent.popoverPresentationController {
                popover.sourceView = viewControllerToPresent.view
                popover.barButtonItem = .none
                popover.sourceRect = viewControllerToPresent.accessibilityFrame
            }
        }
        present(viewControllerToPresent, animated: animated, completion: completion)
    }
}
#endif
