//
//  DisplayMode.swift
//  ThunderApp
//  
//  Created by devonly on 2024/07/16.
//  Copyright © 2024 Magi. All rights reserved.
//

import Foundation

enum DisplayMode: String, CaseIterable, Identifiable {
    var id: RawValue { rawValue }
    case SINGLE
    case TAB
    case CAROUSEL
}
