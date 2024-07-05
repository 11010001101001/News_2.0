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
            CachedAsyncImage(article: article, viewModel: viewModel)
            otherContent
            Spacer()
        }
        .navigationTitle("Details")
    }

    private var otherContent: some View {
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
        .onAppear { rotating.toggle() }
    }

    private var description: some View {
        HStack {
            Text(article.description ?? "Loading...")
            Spacer()
        }
    }

    private var buttons: some View {
        HStack {
            ShareButton(viewModel: viewModel,
                        data: ButtonMetaData(article: article,
                                             title: "Share",
                                             iconName: "square.and.arrow.up"))
            OpenWebViewButton(viewModel: viewModel,
                              data: ButtonMetaData(article: article,
                                                   title: "Open",
                                                   iconName: "link"))
            Spacer()
        }
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
