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
    init(_ value: LocalizableString) {
        self.init(value.description)
    }
}
