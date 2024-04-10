//
//  ShareButton.swift
//  News
//
//  Created by Ярослав Куприянов on 10.04.2024.
//

import Foundation
import SwiftUI

struct ShareButton: View {

    @ObservedObject var viewModel: ViewModel

    @State private var imageWrapper: ContentWrapper?

    let data: ButtonMetaData

    var body: some View {
        CustomButton(viewModel: viewModel,
                     action: { Task { wrapActivityVcAction?() } },
                     title: data.title,
                     iconName: data.iconName)

        .sheet(item: $imageWrapper,
               content: { content in getContent(content: content) })
    }

    private var wrapActivityVcAction: Action {
        {
            self.imageWrapper = ContentWrapper(
                link: URL(string: data.article.url ?? .empty)?.absoluteString ?? .empty,
                description: DeveloperInfo.shareInfo.rawValue)
        }
    }

    private func getContent(content: ContentWrapper) -> some View {
        ActivityViewController(contentWrapper: content)
            .presentationDetents([.medium])
    }
}
