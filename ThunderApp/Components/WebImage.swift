//
//  WebImage.swift
//  ThunderApp
//  
//  Created by devonly on 2024/06/14.
//  Copyright © 2024 Magi. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI
import Raccoon
import Thunder

struct SPImage: View {
    private let assetURL: URL?

    init<T: StaticMedia>(_ media: T) {
        self.assetURL = media.assetURL
    }

    init<T: URLConvertible>(_ value: T) {
        self.assetURL = value.assetURL
    }

    init(url assetURL: URL) {
        self.assetURL = assetURL
    }

    var body: WebImage<Image> {
        WebImage(url: assetURL)
            .onSuccess(perform: { image, data, type in
            })
            .resizable()
    }
}

extension SPImage {
    func renderingMode(_ renderingMode: Image.TemplateRenderingMode) -> some View {
        body.renderingMode(renderingMode)
    }
}
