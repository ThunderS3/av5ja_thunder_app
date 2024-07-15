//
//  WeaponListView.swift
//  ThunderApp
//  
//  Created by devonly on 2024/07/15.
//  Copyright © 2024 Magi. All rights reserved.
//

import SwiftUI
import Thunder

struct WeaponListView: View {
    let weaponList: [WeaponList]
    
    var body: some View {
        ScrollView(content: {
            _body
        })
        .navigationTitle(Text(LocalizedType.CoopHistorySupplyWeapon))
    }
   
    @ViewBuilder
    private var _body: some View {
        LazyVGrid(columns: .init(repeating: .init(.flexible(), spacing: 1), count: 5), spacing: 1, content: {
            ForEach(weaponList, content: { weapon in
                VStack(
                    spacing: 0,
                    content: {
                        SPImage(weapon.id)
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                            .padding(.top, 4)
                        Text(weapon.count, format: .number())
                            .font(.custom(.Splatfont2, size: 14))
                            .foregroundColor(SPColor.SP3.SPAzure)
                            .padding(.bottom, 2)
                    })
                .frame(maxWidth: .infinity)
                .background(content: {
                    Rectangle()
                        .fill(SPColor.SP3.SPSalmonOrangeDarker)
                })
                .grayscale(weapon.count == 0 ? 1.0 : 0.0)
            })
        })
    }
}

#Preview {
    WeaponListView(weaponList: [])
}
