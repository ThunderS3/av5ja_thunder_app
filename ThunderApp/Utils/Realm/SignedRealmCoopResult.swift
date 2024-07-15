//
//  SignedRealmCoopResult.swift
//  ThunderApp
//  
//  Created by devonly on 2024/07/15.
//  Copyright © 2024 Magi. All rights reserved.
//

import Foundation
import RealmSwift

final class SignedRealmCoopResult: Codable {
    let signature: Data
    let schedules: [RealmCoopSchedule]

    init(signature: Data, schedules: RealmSwift.Results<RealmCoopSchedule>) {
        self.signature = signature
        self.schedules = .init(schedules)
    }
    
    init(signature: Data, schedules: [RealmCoopSchedule]) {
        self.signature = signature
        self.schedules = schedules
    }
}
