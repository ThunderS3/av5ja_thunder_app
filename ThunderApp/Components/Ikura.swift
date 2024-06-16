//
//  Ikura.swift
//  ThunderApp
//  
//  Created by devonly on 2024/06/15.
//  Copyright © 2024 Magi. All rights reserved.
//

import SwiftUI
import Raccoon
import Thunder

@ViewBuilder
var Ikura: some View {
    SPImage(Media.SP2.PNG.Ikura)
        .scaledToFit()
}

@ViewBuilder
var GoldenIkura: some View {
    SPImage(Media.SP2.PNG.GolenIkura)
        .scaledToFit()
}

@ViewBuilder
func Rescue(_ value: Species) -> some View {
    SPImage(Media.SP2.PNG.Rescue(value))
        .scaledToFit()
}

@ViewBuilder
func Death(_ value: Species) -> some View {
    SPImage(Media.SP2.PNG.Death(value))
        .scaledToFit()
}
