//
//  Text.swift
//  ThunderApp
//  
//  Created by devonly on 2024/06/15.
//  Copyright © 2024 Magi. All rights reserved.
//

import Foundation
import Thunder
import SwiftUI

extension Text {
    init<T: LocalizableString>(_ value: Optional<T>) {
        if let value: T = value {
            self.init(value.description)
        } else {
            self.init(verbatim: "-")
        }
    }
}
