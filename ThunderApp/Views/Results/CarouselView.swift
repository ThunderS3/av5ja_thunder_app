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
    @ObservedResults(RealmCoopResult.self, sortDescriptor: .init(keyPath: "playTime", ascending: false)) var results
    @State private var isPresented: Bool = true
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
                .scrollTargetLayout()
                .onAppear(perform: {
                    proxy.scrollTo(result.id, anchor: .center)
                })
            })
        })
        .environment(\.visible, $isPresented)
        .scrollTargetBehavior(.viewAligned)
    }
}

struct CarouselTabView: View {
    @ObservedResults(RealmCoopResult.self, sortDescriptor: .init(keyPath: "playTime", ascending: false)) var results
    @State private var isPresented: Bool = true
    @State private var selection: String
    let result: RealmCoopResult
    
    init(result: RealmCoopResult) {
        self.result = result
        self._selection = .init(initialValue: result.id)
    }
    
    var body: some View {
        TabView(selection: $selection, content: {
            ForEach(results, content: { result in
                ResultDetailView(result: result)
                    .id(result.id)
                    .tag(result.id)
                    .containerRelativeFrame(.horizontal)
                    .padding(.horizontal, 16)
            })
        })
        .tabViewStyle(.page(indexDisplayMode: .never))
        .environment(\.visible, $isPresented)
    }
}

#Preview {
    ResultsView()
}
