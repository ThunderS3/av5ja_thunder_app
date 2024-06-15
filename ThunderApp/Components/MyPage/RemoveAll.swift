//
//  RemoveAll.swift
//  ThunderApp
//  
//  Created by devonly on 2024/06/16.
//  Copyright © 2024 Magi. All rights reserved.
//

import SwiftUI

struct RemoveAll: View {
    @Environment(\.realm) var realm
    
    var body: some View {
        Button(action: {
            realm.removeAll()
        }, label: {
            Text("Remove All")
                .font(.custom(.Splatfont2, size: 16))
        })
    }
}

#Preview {
    RemoveAll()
}
