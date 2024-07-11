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
                     action: {
            self.imageWrapper = ContentWrapper(
                link: URL(string: data.article.url ?? .empty)?.absoluteString ?? .empty,
                description: DeveloperInfo.shareInfo.rawValue)
        },
                     title: data.title,
                     iconName: data.iconName)

        .sheet(item: $imageWrapper, content: { content in
            ActivityViewController(contentWrapper: content)
                .presentationDetents([.medium])
        })
    }
}
