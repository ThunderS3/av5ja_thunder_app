//
//  mainApp.swift
//  Salmonia3+
//
//  Created by devonly on 2024/06/02.
//

import SwiftUI
import Raccoon
import SwiftyLogger
import Firebolt
import SDWebImageSVGCoder

@main
struct mainApp: App {
    @Environment(\.scenePhase) var scenePhase
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @State private var manager: RealmManager = .init()
    @StateObject private var config: ThunderConfig = .default

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.realm, RealmMigration.realm)
                .environment(\.realmConfiguration, RealmMigration.configuration)
                .environmentObject(config)
                .overrideUserInterfaceStyle(config.preferredColorScheme, scenePhase)
                .addScenePhaseObserver(scenePhase)
                .fullScreenCover(isPresented: config.$isFirstLaunch, content: {
                    MudmouthView()
                })
        }
    }

    class AppDelegate: NSObject, UIApplicationDelegate, UIWindowSceneDelegate {
        var window: UIWindow?
        private let config: ThunderConfig = .default

        func application(
            _ application: UIApplication,
            willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
        ) -> Bool { true }

        func application(
            _ application: UIApplication,
            didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
        ) -> Bool {
            SwiftyLogger.configure(useNSLog: true, userTerminalColors: true, colored: true)

            if let documentURL: URL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                SwiftyLogger.verbose(documentURL.absoluteURL)
            }

            UNUserNotificationCenter.current().delegate = self
            SDImageCodersManager.shared.addCoder(SDImageSVGCoder.shared)
            
            if config.fetchOnLaunch {
                Raccoon.configure()
            }
            Raccoon.registerFontDescriptors()
            return true
        }

        func application(
            _ application: UIApplication,
            configurationForConnecting connectingSceneSession: UISceneSession,
            options: UIScene.ConnectionOptions
        ) -> UISceneConfiguration {
            let config = UISceneConfiguration(name: nil, sessionRole: connectingSceneSession.role)
            config.delegateClass = AppDelegate.self
            return config
        }

        func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {}

        func scene(
            _ scene: UIScene,
            willConnectTo session: UISceneSession,
            options connectionOptions: UIScene.ConnectionOptions
        ) {
            if let url = connectionOptions.urlContexts.first?.url {}
        }

        func sceneDidBecomeActive(_ scene: UIScene) {}
    }
}

extension mainApp.AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse) async {
        if Firebolt.configure(response: response) {
            if config.isFirstLaunch {
                config.isFirstLaunch.toggle()
            }
        }
    }
}
