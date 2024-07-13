//
//  FormatStyle.swift
//  ThunderApp
//  
//  Created by devonly on 2024/06/17.
//  Copyright © 2024 Magi. All rights reserved.
//

import Foundation
import RealmSwift

internal enum Number {
    struct IntegerFormatStyle<T: BinaryInteger>: Foundation.FormatStyle {
        typealias FormatInput = Optional<T>
        typealias FormatOutput = String

        func format(_ value: FormatInput) -> FormatOutput {
            guard let value: T = value else {
                return "-"
            }
            return value.description
        }
    }
    
    struct NumberFormatStyle<T: BinaryFloatingPoint>: Foundation.FormatStyle where T: CVarArg {
        typealias FormatInput = Optional<T>
        typealias FormatOutput = String
        
        let precision: Int
        
        init(precision: Int = 0) {
            self.precision = precision
        }
        
        func format(_ value: Optional<T>) -> String {
            guard let value: T = value else {
                return "-"
            }
            return String(format: "%.\(precision)f", value)
        }
    }
    
    struct DecimalFormatStyle<T: Decimal128>: Foundation.FormatStyle where T: CVarArg {
        typealias FormatInput = Optional<T>
        typealias FormatOutput = String
        
        let precision: Int
        
        init(precision: Int = 0) {
            self.precision = precision
        }
        
        func format(_ value: Optional<T>) -> String {
            guard let value: T = value else {
                return "-"
            }
            return String(format: "%.\(precision)f", value.doubleValue)
        }
    }
    
    struct PercentFormatStyle<T: BinaryFloatingPoint>: Foundation.FormatStyle where T: CVarArg {
        typealias FormatInput = Optional<T>
        typealias FormatOutput = String
        
        let precision: Int
        
        init(precision: Int = 0) {
            self.precision = precision
        }
        
        func format(_ value: Optional<T>) -> String {
            guard let value: T = value else {
                return "-"
            }
            return String(format: "%.\(precision)f%%", value * 100)
        }
    }
}

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
extension FormatStyle where Self == Number.IntegerFormatStyle<Int> {
    static func number() -> Number.IntegerFormatStyle<Int> {
        Number.IntegerFormatStyle()
    }
}

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
extension FormatStyle where Self == Number.NumberFormatStyle<CGFloat> {
    static func number(_ p: Int = 0) -> Number.NumberFormatStyle<CGFloat> {
        Number.NumberFormatStyle(precision: p)
    }
}

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
extension FormatStyle where Self == Number.NumberFormatStyle<Double> {
    static func number(_ p: Int = 0) -> Number.NumberFormatStyle<Double> {
        Number.NumberFormatStyle(precision: p)
    }
}

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
extension FormatStyle where Self == Number.DecimalFormatStyle<Decimal128> {
    static func number(_ p: Int = 0) -> Number.DecimalFormatStyle<Decimal128> {
        Number.DecimalFormatStyle(precision: p)
    }
}

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
extension FormatStyle where Self == Number.PercentFormatStyle<Double> {
    static func percent(_ p: Int = 0) -> Number.PercentFormatStyle<Double> {
        Number.PercentFormatStyle(precision: p)
    }
}
