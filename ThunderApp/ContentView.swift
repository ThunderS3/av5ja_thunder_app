//
//  ContentView.swift
//  Salmonia3+
//
//  Created by devonly on 2024/06/02.
//

import SwiftUI

struct ContentView: View {
    @State private var selection: Int = 0

    var body: some View {
        TabView(
            selection: $selection,
            content: {
                NavigationView(content: {
                    MyPageView()
                })
                .navigationViewStyle(.split)
                .tag(0)
                .tabItem({
                    Image(systemName: "person.circle.fill")
                    Text("My page")
                })
                NavigationView(content: {
                    ResultsView()
                })
                .navigationViewStyle(.split)
                .tag(1)
                .tabItem({
                    Image(systemName: "list.dash")
                    Text("Results")
                })
                NavigationView(content: {
                    SchedulesView()
                })
                .navigationViewStyle(.split)
                .tag(2)
                .tabItem({
                    Image(systemName: "calendar")
                    Text("Schedules")
                })
            }
        )
    }
}

#Preview {
    ContentView()
}
