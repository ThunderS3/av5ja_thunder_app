//
//  RealmCollection.swift
//  ThunderApp
//  
//  Created by devonly on 2024/07/14.
//  Copyright © 2024 Magi. All rights reserved.
//

import Foundation
import RealmSwift

extension RealmCollection {
    var size: Int? { count == .zero ? nil : count }

    func sumValue<T: _HasPersistedType>(ofProperty property: String) -> T? where T.PersistedType: AddableType {
        count == .zero ? nil : sum(ofProperty: property)
    }
    
    func avgValue<T: _HasPersistedType>(ofProperty property: String) -> T? where T.PersistedType: AddableType {
        count == .zero ? nil : average(ofProperty: property)
    }
    
    func maxValue<T: _HasPersistedType>(ofProperty property: String) -> T? where T.PersistedType: MinMaxType {
        count == .zero ? nil : max(ofProperty: property)
    }

    func statics(ofProperty key: String) -> Statics {
        .init(
            max: max(ofProperty: key),
            sum: sum(ofProperty: key),
            avg: average(ofProperty: key)
        )
    }
}
