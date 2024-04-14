//
//  Topic.swift
//  News
//
//  Created by Ярослав Куприянов on 26.03.2024.
//

import SwiftUI
import UIKit

struct TopicDetail: View {

    @ObservedObject var viewModel: ViewModel

    let article: Article

    @State private var rotating = false

    var body: some View {
        VStack {
            getAsyncImage()
            contents
            Spacer()
        }
        .navigationTitle("Details")
    }

    private func getAsyncImage() -> some View {
        AsyncImage(url: URL(string: article.urlToImage ?? .empty)) { phase in
            if let image = phase.image {
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: CGFloat.screenWidth - 32,
                           height: 300,
                           alignment: .center)
                    .clipped()
                    .clipShape(.buttonBorder)
                    .shadow(color: Color(image.averageColor), radius: 60)
                    .applyNice3DRotation(rotating: rotating)
                    .commonScaleAffect(state: rotating)
                    .onAppear { onAppear() }
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
            }
        }
        .frame(height: 300)
        .padding([.vertical, .horizontal])
    }

    private var contents: some View {
        VStack {
            description
            buttons
                .padding(.top)
        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 26)
                .fill(.rowBackground)
        }
        .padding(.horizontal)
        .commonScaleAffect(state: rotating)
    }

    private var description: some View {
        HStack {
            Text(article.description ?? .empty)
            Spacer()
        }
    }

    private var buttons: some View {
        HStack {
            ShareButton(viewModel: viewModel,
                        data: ButtonMetaData(article: article,
                                             title: "Share",
                                             iconName: "square.and.arrow.up"))
            OpenLinkButton(viewModel: viewModel,
                           data: ButtonMetaData(article: article,
                                                title: "Open",
                                                iconName: "link"))
            Spacer()
        }
    }

    private func onAppear() {
        rotating.toggle()
        viewModel.markAsRead(article.key)
    }
}

#Preview {
    // swiftlint:disable line_length
    TopicDetail(viewModel: ViewModel(),
                article: Article(source: Source(id: UUID().uuidString,
                                                name: "Source"),
                                 title: "Title",
                                 description: "Very long description of the topic if you really want this for testing for example i dont know what to type more here but i guess it's enough",
                                 publishedAt: "Time"))
    // swiftlint:enable line_length
}
