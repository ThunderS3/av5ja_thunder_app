//
//  MudmouthView.swift
//  ThunderApp
//
//  Created by devonly on 2024/06/11.
//  Copyright © 2024 Magi. All rights reserved.
//

import Foundation
import SwiftUI
import Mudmouth

struct MudmouthView: View {
    @State private var selection: TabItem = .MUDMOUTH

    var body: some View {
        TabView(selection: $selection, content: {
            ForEach(TabItem.allCases, content: { tabItem in
                DescriptionView(title: {
                    Text(tabItem.title)
                }, content: {
                    EmptyView()
                })
                .tag(tabItem)
            })
        })
        .disabled(true)
        .overlay(alignment: .bottom, content: {
            VStack(content: {
                selection.content
                NextButton()
                BackButton()
            })
        })
        .background(content: {
            BackgroundWave()
        })
        .tabViewStyle(.page(indexDisplayMode: .never))
    }

    private func NextButton() -> some View {
        Button(
            action: {
                withAnimation(.default) {
                    selection.next()
                }
            },
            label: {
                Text("Next")
            }
        ).buttonStyle(.float)
    }

    private func BackButton() -> some View {
        Button(
            action: {
                withAnimation(.default) {
                    selection.back()
                }
            },
            label: {
                Text("Back")
            }
        ).buttonStyle(.float)
    }
}

private enum TabItem: Int, CaseIterable, Identifiable {
    var id: Int { rawValue}

    case MUDMOUTH
    case INSTALL
    case CONNECT

    var title: String {
        switch self {
        case .MUDMOUTH:
            return "Mudmouth"
        case .INSTALL:
            return "Install"
        case .CONNECT:
            return "Connect"
        }
    }

    mutating func next() { self = Self(rawValue: self.rawValue + 1) ?? .MUDMOUTH }

    mutating func back() { self = Self(rawValue: self.rawValue - 1) ?? .MUDMOUTH }

    @ViewBuilder
    var content: some View {
        switch self {
        case .MUDMOUTH:
            EmptyView()
        case .INSTALL:
            InstallLink()
                .buttonStyle(.float)
        case .CONNECT:
            Connect()
                .buttonStyle(.float)
        }
    }
}

#Preview {
    MudmouthView()
}
