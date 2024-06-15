//
//  SecretKeys.swift
//  Firebolt
//  
//  Created by devonly on 2024/06/15.
//  Copyright © 2024 Magi. All rights reserved.
//

import Foundation
import SwiftPackageKeys

final class SecretKeys {
    static let gameWebToken: String = {
        guard let value: String = SwiftPackageKeys.gameWebToken.value else {
            fatalError("GameWebToken is not set")
        }
        return value
    }()

    static let bulletToken: String = {
        guard let value: String = SwiftPackageKeys.bulletToken.value else {
            fatalError("BulletToken is not set")
        }
        return value
    }()

    static let xWebViewVer: String = {
        guard let value: String = SwiftPackageKeys.xWebViewVer.value else {
            fatalError("X-Web-View-Ver is not set")
        }
        return value
    }()

    static let userAgent: String = {
        guard let value: String = SwiftPackageKeys.userAgent.value else {
            fatalError("UserAgent is not set")
        }
        return value
    }()
}
