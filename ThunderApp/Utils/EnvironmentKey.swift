//
//  EnvironmentKey.swift
//  ThunderApp
//  
//  Created by devonly on 2024/06/16.
//  Copyright © 2024 Magi. All rights reserved.
//

import Foundation
import SwiftUI

struct PlayerNameKey: EnvironmentKey {
    static var defaultValue: Binding<Bool> = .constant(true)
}

public class VisibleName {
    private var isPresented: Binding<Bool>
    
    private func toggle() {
        isPresented.wrappedValue.toggle()
    }

    init() {
        self.isPresented = .constant(true)
    }
}

extension EnvironmentValues {
    var visible: Binding<Bool> {
        get {
            self[PlayerNameKey.self]
        }
        set {
            self[PlayerNameKey.self] = newValue
        }
    }
}
