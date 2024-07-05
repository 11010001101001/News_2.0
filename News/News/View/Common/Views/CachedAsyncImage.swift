//
//  CachedAsyncImage.swift
//  News
//
//  Created by Ярослав Куприянов on 04.07.2024.
//

import SwiftUI

struct CachedAsyncImage: View {

    let article: Article

    @State private var rotating = false

    @ObservedObject var viewModel: ViewModel

    private var url: String {
        article.urlToImage ?? .empty
    }

    private var key: AnyObject {
        url as AnyObject
    }

    private var cachedImage: Image? {
        viewModel.getCachedImage(key: key)
    }

    var body: some View {
        cachedAsyncImage()
            .padding([.vertical, .horizontal])
    }

    @ViewBuilder
    private func cachedAsyncImage() -> some View {
        if let cachedImage {
            cachedImage
                .makeRounded(height: Constants.imageHeight)
                .applyNice3DRotation(rotating: rotating)
                .commonScaleAffect(state: rotating)
                .onAppear { onAppear() }
        } else {
            AsyncImage(url: URL(string: url)) { phase in
                if let image = phase.image {
                    image
                        .onAppear { onAppear(image) }
                } else if phase.error != nil {
                    ErrorView(viewModel: viewModel, action: nil)
                    .applyNice3DRotation(rotating: rotating)
                    .commonScaleAffect(state: rotating)
                    .frame(height: Constants.imageHeight)
                    .onAppear { onAppear() }
                } else {
                    Loader(loaderName: viewModel.loader,
                           shadowColor: LoaderConfiguration(rawValue: viewModel.loader)?.shadowColor ?? .clear)
                    .frame(height: Constants.imageHeight)
                }
            }
        }
    }

    private func onAppear(_ image: Image? = nil) {
        if image == nil {
            rotating.toggle()
        }

        viewModel.markAsRead(article.key)
        cache(image)
    }

    private func cache(_ image: Image?) {
        guard let image, cachedImage == nil else { return }
        let object = CachedImage(image: image)
        viewModel.cache(object: object, key: key)
    }
}
