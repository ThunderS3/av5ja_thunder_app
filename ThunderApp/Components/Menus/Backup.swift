//
//  Backup.swift
//  ThunderApp
//
//  Created by devonly on 2024/07/15.
//  Copyright © 2024 Magi. All rights reserved.
//

import SwiftUI
import Thunder

struct Backup: View {
    var body: some View {
        Button(action: {
            Task(priority: .background, operation: {
                let destinationURL: URL = try await RealmSigner.backup()
                let activity: UIActivityViewController = .init(
                    activityItems: [destinationURL],
                    applicationActivities: nil
                )
                activity.completionWithItemsHandler = { _, _, _, _ in try? RealmSigner.deleteAll() }
                UIApplication.shared.presentedViewController?.popover(activity, animated: true)
            })
        },label: {
            Text(LocalizedType.CommonBackupResults)
        })
    }
}

#Preview {
    Backup()
}
