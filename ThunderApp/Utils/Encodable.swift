//
//  Encodable.swift
//  ThunderApp
//  
//  Created by devonly on 2024/06/16.
//  Copyright © 2024 Magi. All rights reserved.
//

import Foundation

extension Encodable {
    var dictionaryObject: [String: Any] {
        Mirror(reflecting: self).children.reduce(
            into: [String: Any](),
            { results, result in
                guard let key: String = result.label else { return }
                results[key] = result.value
            }
        )
    }
}
