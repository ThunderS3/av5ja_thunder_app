//
//  RealmCollection+Player.swift
//  ThunderApp
//  
//  Created by devonly on 2024/07/14.
//  Copyright © 2024 Magi. All rights reserved.
//

import Foundation
import RealmSwift

extension RealmCollection where Element == RealmCoopPlayer {
    /// スケジュールでのプレイヤーイクラ統計
    var ikuraNum: Statics {
        statics(ofProperty: "ikuraNum")
    }

    /// スケジュールでのプレイヤー金イクラ統計
    var goldenIkuraNum: Statics {
        statics(ofProperty: "goldenIkuraNum")
    }

    /// スケジュールでのプレイヤー被救助数統計
    var deadCount: Statics {
        statics(ofProperty: "deadCount")
    }

    /// スケジュールでのプレイヤー救助数統計
    var helpCount: Statics {
        statics(ofProperty: "helpCount")
    }
}
