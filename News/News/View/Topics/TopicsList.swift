//
//  TopicsList.swift
//  News
//
//  Created by Ярослав Куприянов on 29.03.2024.
//

import SwiftUI

struct TopicsList: View {

    @ObservedObject var viewModel: ViewModel

    @State private var scrollToTop = false

    var body: some View {
        ScrollViewReader { proxy in
            ZStack {
                Loader(loaderName: viewModel.loader,
                       shadowColor: LoaderConfiguration(rawValue: viewModel.loader)?.shadowColor ?? .clear)
                    .opacity($viewModel.loadingFailed.wrappedValue ? .zero : 1.0)
                    .id(viewModel.id)

                getTopicsList(proxy: proxy)

                ErrorView(
                    viewModel: viewModel,
                    title: $viewModel.failureReason.wrappedValue,
                    action: { viewModel.loadNews() })
                .opacity($viewModel.loadingFailed.wrappedValue ? 1.0 : .zero)
            }
        }
    }

    private func getTopicsList(proxy: ScrollViewProxy) -> some View {
        List {
            getTopView(proxy: proxy)

            ForEach($viewModel.newsArray) { $item in
                NavigationLink {
                    TopicDetail(viewModel: viewModel,
                                article: item,
                                action: nil)
                } label: {
                    TopicCell(article: item)
                        .ignoresSafeArea()
                }
            }

            ReturnCell() {
                viewModel.impactOccured(.light)
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5,
                                              execute: {
                    scrollToTop.toggle()
                })
            }
        }
        .listStyle(.plain)
        .opacity($viewModel.loadingSucceed.wrappedValue ? 1.0 : .zero)
    }

    /// For scrolling to `top` only
    private func getTopView(proxy: ScrollViewProxy) -> some View {
        EmptyView()
            .id("top")
            .onChange(of: scrollToTop) {
                withAnimation {
                    proxy.scrollTo("top", anchor: .bottom)
                }
            }
    }
}

#Preview {
    TopicsList(viewModel: ViewModel())
}
