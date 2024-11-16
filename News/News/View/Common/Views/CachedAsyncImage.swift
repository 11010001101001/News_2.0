//
//  CachedAsyncImage.swift
//  News
//
//  Created by Ярослав Куприянов on 04.07.2024.
//

import SwiftUI

struct CachedAsyncImage: View {
	private let article: Article
    @State private var rotating = false
    @ObservedObject private var viewModel: ViewModel

    private var url: String {
        article.urlToImage ?? .empty
    }

    private var key: AnyObject {
        url as AnyObject
    }

    private var cachedImage: Image? {
        viewModel.getCachedImage(key: key)
    }
	
	init(article: Article, rotating: Bool = false, viewModel: ViewModel) {
		self.article = article
		self.rotating = rotating
		self.viewModel = viewModel
	}
	
	var body: some View {
		cachedAsyncImage().padding([.vertical, .horizontal])
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
						.resizable()
                        .onAppear { cache(image) }
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

    private func onAppear() {
        rotating.toggle()
        viewModel.markAsRead(article.key)
    }

    private func cache(_ image: Image) {
        let object = CachedImage(image: image)
        viewModel.cache(object: object, key: key)
    }
}
