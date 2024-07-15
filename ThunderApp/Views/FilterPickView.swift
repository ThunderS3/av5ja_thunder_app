//
//  FilterPickView.swift
//  ThunderApp
//  
//  Created by devonly on 2024/07/15.
//  Copyright © 2024 Magi. All rights reserved.
//

import SwiftUI
import UniformTypeIdentifiers

public struct FilePickView: View {
    public typealias Completeion = (URL) -> Void
    let fileType: [UTType]
    let onSelected: (URL) -> Void

    public init(fileType: [UTType], onSelected: @escaping Completeion) {
        self.fileType = fileType
        self.onSelected = onSelected
    }

    public var body: some View {
        _FilePickView(fileType: fileType, onSelected: onSelected)
    }
}

private struct _FilePickView: UIViewControllerRepresentable {
    let fileType: [UTType]
    let onSelected: (URL) -> Void

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func updateUIViewController(_: UIDocumentPickerViewController, context _: Context) {}

    func makeUIViewController(context: Context) -> UIDocumentPickerViewController {
        let controller = UIDocumentPickerViewController(forOpeningContentTypes: fileType, asCopy: true)
        controller.delegate = context.coordinator
        return controller
    }

    class Coordinator: NSObject, UIDocumentPickerDelegate {
        var parent: _FilePickView

        init(_ parent: _FilePickView) {
            self.parent = parent
        }

        func documentPicker(_: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
            if let url = urls.first {
                parent.onSelected(url)
            }
        }
    }
}

//#Preview {
//    FilterPickView()
//}
