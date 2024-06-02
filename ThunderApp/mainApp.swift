//
//  mainApp.swift
//  Salmonia3+
//
//  Created by devonly on 2024/06/02.
//

import SwiftUI
import Raccoon

@main
struct mainApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.realmConfiguration, RealmMigration.configuration)
        }
    }

    class AppDelegate: NSObject, UIApplicationDelegate, UIWindowSceneDelegate {
        var window: UIWindow?

        func application(
            _ application: UIApplication,
            willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
        ) -> Bool { true }

        func application(
            _ application: UIApplication,
            didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
        ) -> Bool {
            Raccoon.configure()
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
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse) async {}
}
