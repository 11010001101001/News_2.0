//
//  CachedAsyncImage.swift
//  News
//
//  Created by Ярослав Куприянов on 04.07.2024.
//

import SwiftUI

struct CachedAsyncImage: View {

    let article: Article

    @State var rotating = false

    @ObservedObject var viewModel: ViewModel

    private var url: String {
        article.urlToImage ?? .empty
    }

    private var key: AnyObject {
        url as AnyObject
    }

    var body: some View {
        cachedAsyncImage()
            .padding([.vertical, .horizontal])
    }

    @ViewBuilder
    private func cachedAsyncImage() -> some View {
        if let image = (CacheManager.shared.get(key: key as AnyObject) as? CachedImage)?.image {
            image
                .makeRounded(height: Constants.imageHeight)
                .applyNice3DRotation(rotating: rotating)
                .commonScaleAffect(state: rotating)
                .onAppear { onAppear(image) }
        } else {
            AsyncImage(url: URL(string: url)) { phase in
                if let image = phase.image {
                    image
                        .makeRounded(height: Constants.imageHeight)
                        .applyNice3DRotation(rotating: rotating)
                        .commonScaleAffect(state: rotating)
                        .onAppear { onAppear(image) }
                } else if phase.error != nil {
                    ErrorView(
                        viewModel: viewModel,
                        title: "Error loading image...",
                        action: nil)
                    .applyNice3DRotation(rotating: rotating)
                    .commonScaleAffect(state: rotating)
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
        rotating.toggle()
        viewModel.markAsRead(article.key)
        cache(image)
    }

    private func cache(_ image: Image?) {
        guard let image, CacheManager.shared.get(key: key as AnyObject) == nil else { return }
        let object = CachedImage(image: image)
        Task {
            CacheManager.shared.save(object: object, key: key as AnyObject)
        }
    }
}
