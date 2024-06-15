//
//  ResultStatus.swift
//  ThunderApp
//  
//  Created by devonly on 2024/06/15.
//  Copyright © 2024 Magi. All rights reserved.
//

import SwiftUI
import Thunder

struct ResultStatus: View {
    let result: RealmCoopResult

    var body: some View {
        HStack(content: {
            VStack(spacing: 0, content: {
                HStack(spacing: 0, content: {
                    GoldenIkura
                        .frame(width: 24, height: 20)
                    Text(result.goldenIkuraNum, format: .number)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .font(.custom(.Splatfont2, size: 14))
                })
                .frame(width: 73.32, height: 22)
                HStack(spacing: 0, content: {
                    Ikura
                        .frame(width: 24, height: 20)
                    Text(result.ikuraNum, format: .number)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .font(.custom(.Splatfont2, size: 14))
                })
                .frame(width: 73.32, height: 22)
            })
            Spacer()
            VStack(alignment: .leading, spacing: 4, content: {
                if let gradeId: CoopGrade.Id = result.gradeId,
                   let gradePoint = result.gradePoint {
                    Text(gradeId)
                        .font(.custom(.Splatfont2, size: 14))
                        .frame(maxWidth: .infinity, alignment: .trailing)
                    ZStack(alignment: .leading, content: {
                        GeometryReader(content: { geometry in
                            Rectangle()
                                .fill(SPColor.SP2.SPOrange)
                                .frame(width: geometry.size.width * min(1, CGFloat(gradePoint) * 0.01), height: 15, alignment: .leading)
                            Rectangle()
                                .fill(SPColor.SP2.SPBackground)
                                .frame(width: geometry.size.width, height: 15, alignment: .leading)
                        })
                    })
                }
            })
            .background(content: {
                Color.blue.opacity(0.3)
            })
            .frame(width: 160)
        })
        .frame(height: 48)
    }
}

#Preview {
    ResultStatus(result: .preview)
}
