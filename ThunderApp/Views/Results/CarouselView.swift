//
//  Carousel.swift
//  ThunderApp
//  
//  Created by devonly on 2024/06/16.
//  Copyright © 2024 Magi. All rights reserved.
//

import SwiftUI
import RealmSwift

struct CarouselView: View {
//    let results: [RealmCoopResult] = [
//        .preview(),
//        .preview()
//    ]
    @ObservedResults(RealmCoopResult.self, sortDescriptor: .init(keyPath: "playTime", ascending: false)) var results
    let result: RealmCoopResult
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false, content: {
            ScrollViewReader(content: { proxy in
                LazyHStack(content: {
                    ForEach(results, content: { result in
                        ResultDetailView(result: result)
                            .id(result.id)
                            .containerRelativeFrame(.horizontal)
                    })
                })
                .onAppear(perform: {
                    proxy.scrollTo(result.id, anchor: .center)
                })
                .scrollTargetLayout()
            })
        })
//        .contentMargins(.horizontal, 50, for: .scrollContent)
        .scrollTargetBehavior(.viewAligned)
    }
}

//#Preview {
//    CarouselView()
//}
