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
    @State private var animateBackgroundGradient = false

    var body: some View {
        ScrollViewReader { proxy in
            ZStack {
                getTopicsList(proxy: proxy)

                Loader(loaderName: viewModel.loader,
                       shadowColor: LoaderConfiguration(rawValue: viewModel.loader)?.shadowColor ?? .clear)
                .opacity($viewModel.loadingSucceed.wrappedValue ? .zero : 1.0)
                .id(viewModel.id)

                ErrorView(
                    viewModel: viewModel,
                    title: $viewModel.failureReason.wrappedValue,
                    action: { viewModel.loadNews() })
                .opacity($viewModel.loadingFailed.wrappedValue ? 1.0 : .zero)
            }
        }
        .onAppear {
            withAnimation(.linear(duration: 30).repeatForever(autoreverses: true)) {
                animateBackgroundGradient = true
            }
        }
    }

    private func getTopicsList(proxy: ScrollViewProxy) -> some View {
        List {
            Section {
                getTopView(proxy: proxy)

                ForEach($viewModel.newsArray) { $item in
                    NavigationLink {
                        TopicDetail(viewModel: viewModel, article: item)
                    } label: {
                        TopicCell(article: item)
                            .ignoresSafeArea()
                            .opacity(getOpacity(item))
                            .shadow(color: .shadowHighlight,
                                    radius: (item.title?.lowercased() ?? .empty).contains("apple") ? 3.0 : .zero)
                    }
                }
            } footer: {
                ReturnCell {
                    viewModel.impactOccured(.light)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5,
                                                  execute: { scrollToTop.toggle() })
                }
            }
            .listRowSeparator(.hidden)
            .listRowBackground(
                RoundedRectangle(cornerRadius: 26)
                    .fill(.rowBackground)
                    .padding(4)
            )
            .listRowInsets(.init(top: Constants.insets.top,
                                 leading: Constants.insets.leading,
                                 bottom: Constants.insets.bottom,
                                 trailing: Constants.insets.trailing))
        }
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

    private func getOpacity(_ topic: Article) -> Double {
        viewModel.checkIsRead(topic.key) ? 0.5 : 1.0
    }
}

#Preview {
    TopicsList(viewModel: ViewModel())
}
