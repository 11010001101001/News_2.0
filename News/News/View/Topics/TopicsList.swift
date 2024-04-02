//
//  TopicsList.swift
//  News
//
//  Created by Ярослав Куприянов on 29.03.2024.
//

import SwiftUI

struct TopicsList: View {
    
    @ObservedObject var viewModel: ViewModel

    var body: some View {
        ZStack {
            Loader()
                .opacity($viewModel.loadingFailed.wrappedValue ? .zero : 1.0)

            List {
                ForEach($viewModel.newsArray) { $item in
                    ZStack {
                        NavigationLink {
                            TopicDetail(viewModel: viewModel,
                                        article: item,
                                        action: nil)
                        } label: {
                            TopicCell(article: item)
                                .ignoresSafeArea()
                        }
                    }
                }
            }
            .listStyle(.plain)
            .opacity($viewModel.loadingSucceed.wrappedValue ? 1.0 : .zero)

            ErrorView(
                viewModel: viewModel,
                title: $viewModel.failureReason.wrappedValue,
                action: { viewModel.loadNews() })
            .opacity($viewModel.loadingFailed.wrappedValue ? 1.0 : .zero)
        }
    }
}

#Preview {
    TopicsList(viewModel: ViewModel())
}
