//
//  SPCircle.swift
//  ThunderApp
//  
//  Created by devonly on 2024/07/15.
//  Copyright © 2024 Magi. All rights reserved.
//

import Foundation
import SwiftUI

struct SPCircle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: width, y: 0.5 * height))
        path.addCurve(
            to: CGPoint(x: 0.5 * width, y: height),
            control1: CGPoint(x: width, y: 0.84412 * height),
            control2: CGPoint(x: 0.84412 * width, y: height)
        )
        path.addCurve(
            to: CGPoint(x: 0, y: 0.5 * height),
            control1: CGPoint(x: 0.15588 * width, y: height),
            control2: CGPoint(x: 0, y: 0.84412 * height)
        )
        path.addCurve(
            to: CGPoint(x: 0.5 * width, y: 0),
            control1: CGPoint(x: 0, y: 0.15588 * height),
            control2: CGPoint(x: 0.15588 * width, y: 0)
        )
        path.addCurve(
            to: CGPoint(x: width, y: 0.5 * height),
            control1: CGPoint(x: 0.84412 * width, y: 0),
            control2: CGPoint(x: width, y: 0.15588 * height)
        )
        path.closeSubpath()
        return path
    }
}
