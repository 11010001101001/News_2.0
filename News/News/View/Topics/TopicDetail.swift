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

    @Environment(\.openURL) private var openURL

    let article: Articles
    let action: Action

    @State private var imageWrapper: ContentWrapper?
    @State private var rotating = false

    var body: some View {
        VStack {
            getAsyncImage()

            VStack {
                Text(article.description ?? .empty)
                buttonsStack
                Spacer()
            }
            .padding(.leading)
            .commonScaleAffect(state: rotating)
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
                    .onAppear { rotating.toggle() }
            } else if phase.error != nil {
                ErrorView(
                    viewModel: viewModel,
                    title: "Error loading image...",
                    action: nil)
                .applyNice3DRotation(rotating: rotating)
                .commonScaleAffect(state: rotating)
                .onAppear { rotating.toggle() }
            } else {
                Loader()
            }
        }
        .frame(height: 300)
        .padding([.vertical, .horizontal])
    }

    private var buttonsStack: some View {
        HStack {
            shareButton
            openLinkButton
            Spacer()
        }
    }

    private var shareButton: some View {
        CustomButton(viewModel: viewModel,
                     action: { Task { wrapActivityVcAction?() } },
                     title: "Share",
                     iconName: "square.and.arrow.up")

        .sheet(item: $imageWrapper,
               content: { content in getContent(content: content) })
    }

    private var wrapActivityVcAction: Action {
        {
            self.imageWrapper = ContentWrapper(
                link: URL(string: article.url ?? .empty)?.absoluteString ?? .empty,
                description: "Link to News app in appStore 🦾: stay informed!👨🏻‍🔧")
        }
    }

    private func getContent(content: ContentWrapper) -> some View {
        ActivityViewController(contentWrapper: content)
            .presentationDetents([.medium])
    }

    private var openLinkButton: some View {
        CustomButton(viewModel: viewModel,
                     action: { Task { openLinkAction?() } },
                     title: "Open",
                     iconName: "link")
    }

    private var openLinkAction: Action {
        {
            action?()
            if let url = URL(string: article.url ?? .empty) {
                openURL(url)
            }
        }
    }
}

#Preview {
    TopicDetail(viewModel: ViewModel(),
                article: Articles(source: Source(id: UUID().uuidString,
                                                 name: "Source"),
                                  title: "Title",
                                  description: "Very long description of the topic if you really want this for testing for example i dont know what to type more here but i guess it's enough",
                                  publishedAt: "Time"),
                action: {
        print("tapped")
    })
}
