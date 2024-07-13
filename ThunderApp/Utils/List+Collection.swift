//
//  List+Collection.swift
//  ThunderApp
//  
//  Created by devonly on 2024/07/13.
//  Copyright © 2024 Magi. All rights reserved.
//

import Foundation
import RealmSwift

extension Collection where Element == List<Int> {
    func sum() -> Element {
        if let first = self.first {
            var sum: List<Int> = Element(contentsOf: Array(repeating: 0, count: first.count))
            self.forEach({ element in sum = sum.add(contentsOf: element) })
            return sum
        }
        return List<Int>()
    }
}

extension Collection where Element == List<Int?> {
    func sum() -> Element {
        if let first = self.first {
            var sum: List<Int?> = Element(contentsOf: Array(repeating: 0, count: first.count))
            self.forEach({ element in sum = sum.add(contentsOf: element) })
            return sum
        }
        return List<Int?>()
    }
}

extension Collection where Element == [Int] {
    func sum() -> Element {
        if let first = self.first {
            var sum: [Int] = Array(repeating: 0, count: first.count)
            self.forEach({ element in sum = sum.add(contentsOf: element) })
            return sum
        }
        return []
    }
}

extension Collection where Element: Comparable {
    func count(_ value: Element) -> Int { filter({ $0 == value }).count }
}

extension Collection where Element == Int {
    func sum() -> Element {
        reduce(0, +)
    }
    
    func avg() -> Double? {
        count == 0 ? nil : Double(sum()) / Double(count)
    }
}

extension RealmSwift.List where Element == Int {
    /// Listの和を返す
    func add(contentsOf content: RealmSwift.List<Int>) -> RealmSwift.List<Int> {
        let results: [Int] = zip(self, content).map({ $0.0 + $0.1 })
        return RealmSwift.List<Int>(contentsOf: results)
    }

    /// Listの差を返す
    func sub(contentsOf content: RealmSwift.List<Int>) -> RealmSwift.List<Int> {
        let results: [Int] = zip(self, content).map({ $0.0 - $0.1 })
        return RealmSwift.List<Int>(contentsOf: results)
    }
}

extension RealmSwift.List where Element == Int? {
    /// Listの和を返す
    func add(contentsOf content: RealmSwift.List<Int?>) -> RealmSwift.List<Int?> {
        let results: [Int?] = zip(self, content).map({ a, b in
            if a == nil && b == nil { return nil }
            return (a ?? 0) + (b ?? 0)
        })
        return RealmSwift.List<Int?>(contentsOf: results)
    }

    /// Listの差を返す
    func sub(contentsOf content: RealmSwift.List<Int?>) -> RealmSwift.List<Int?> {
        let results: [Int?] = zip(self, content).map({ a, b in
            if a == nil && b == nil { return nil }
            return (a ?? 0) + (b ?? 0)
        })
        return RealmSwift.List<Int?>(contentsOf: results)
    }
}

extension Array where Element == Int {
    /// Listの和を返す
    func add(contentsOf content: Self) -> Self {
        let results: [Int] = zip(self, content).map({ $0.0 + $0.1 })
        return results
    }

    /// Listの差を返す
    func sub(contentsOf content: Self) -> Self {
        let results: [Int] = zip(self, content).map({ $0.0 - $0.1 })
        return results
    }
}

extension Array where Element == Int? {
    /// Listの和を返す
    func add(contentsOf content: Self) -> Self {
        let results: [Int?] = zip(self, content).map({ a, b in
            if a == nil && b == nil { return nil }
            return (a ?? 0) + (b ?? 0)
        })
        return results
    }

    /// Listの差を返す
    func sub(contentsOf content: Self) -> Self {
        let results: [Int?] = zip(self, content).map({ a, b in
            if a == nil && b == nil { return nil }
            return (a ?? 0) + (b ?? 0)
        })
        return results
    }
}
