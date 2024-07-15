//
//  SettingsView.swift
//  ThunderApp
//
//  Created by devonly on 2024/07/15.
//  Copyright © 2024 Magi. All rights reserved.
//

import SwiftUI
import Thunder

struct SettingsView: View {
    @EnvironmentObject private var config: ThunderConfig
    
    var body: some View {
        Form(content: {
            Section(
                content: {
                    UseSystemScheme()
                    UseDarkTheme()
                    UseGamingMode()
                },
                header: {
                    Text(LocalizedType.CommonAppearances)
                        .font(.custom(.Splatfont1, size: 16))
                })
            Section(
                content: {
                    SignIn()
                    RemoveAll()
                },
                header: {
                    Text(LocalizedType.CommonDataManagement)
                        .font(.custom(.Splatfont1, size: 16))
                })
        })
        .font(.custom(.Splatfont2, size: 16))
        .navigationTitle(Text(LocalizedType.SettingsTitle))
    }
    
    @ViewBuilder
    private func UseSystemScheme() -> some View {
        Toggle(
            isOn: config.$useSystemColorScheme,
            label: {
                Text(LocalizedType.CommonUseSystemTheme)
            })
    }
    
    @ViewBuilder
    private func UseDarkTheme() -> some View {
        Toggle(
            isOn: config.$usePreferredColorScheme,
            label: {
                Text(LocalizedType.CommonDarkMode)
            })
    }
    
    @ViewBuilder
    private func UseGamingMode() -> some View {
        Toggle(
            isOn: config.$useGamingModeResults,
            label: {
                Text(LocalizedType.CommonGamingMode)
            })
    }
    
    private struct SignIn: View {
        @EnvironmentObject private var config: ThunderConfig
        @State private var isPresented = false
        
        var body: some View {
            Button(action: {
                isPresented.toggle()
            }, label: {
                Text(LocalizedType.CommonSignOut)
            }).alert(
                Text(LocalizedType.CommonSignOut),
                isPresented: $isPresented,
                actions: {
                    Button(role: .cancel, action: {
                        isPresented.toggle()
                    }, label: {
                        Text(LocalizedType.CommonCancel)
                    })
                    Button(
                        role: .destructive,
                        action: { withAnimation(.default, {
                            config.isFirstLaunch.toggle()
                        })
                        },
                        label: {
                            Text(LocalizedType.CommonDecide)
                        }
                    )
                },
                message: {
                    Text(LocalizedType.CommonSignOutMessage)
                })
        }
    }
    
    private struct RemoveAll: View {
        @EnvironmentObject private var config: ThunderConfig
        @Environment(\.realm) var realm
        @State private var isPresented = false
        
        var body: some View {
            Button(action: {
                isPresented.toggle()
            }, label: {
                Text(LocalizedType.CommonWipeResults)
            })
            .alert(
                Text(LocalizedType.CommonWipeResults),
                isPresented: $isPresented,
                actions: {
                    Button(role: .cancel, action: {
                        isPresented.toggle() }, label: {
                            Text(LocalizedType.CommonCancel)
                        })
                    Button(
                        role: .destructive,
                        action: {
                            realm.removeAll()
                        },
                        label: {
                            Text(LocalizedType.CommonDecide)
                        })
                },
                message: { Text(LocalizedType.CommonWipeResultsMessage) }
            )
        }
    }
}

#Preview {
    SettingsView()
}
