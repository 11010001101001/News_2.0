//
//  TopicsList.swift
//  News
//
//  Created by Ярослав Куприянов on 29.03.2024.
//

import SwiftUI

struct TopicsList: View {
	@ObservedObject var viewModel: ViewModel
	@State private var isNeedScrollToTop = false

	var body: some View {
		ScrollViewReader { proxy in
			ZStack {
				buildTopicsList(proxy: proxy)

				Loader(
					loaderName: viewModel.loader,
					shadowColor: LoaderConfiguration(rawValue: viewModel.loader)?.shadowColor ?? .clear
				)
				.opacity($viewModel.loadingSucceed.wrappedValue ? .zero : 1.0)
				.id(viewModel.id)

				ErrorView(
					viewModel: viewModel,
					title: $viewModel.failureReason.wrappedValue,
					action: { viewModel.loadNews() }
				)
				.opacity($viewModel.loadingFailed.wrappedValue ? 1.0 : .zero)
			}
		}
	}
}

// MARK: - Private
private extension TopicsList {
	func buildTopicsList(proxy: ScrollViewProxy) -> some View {
		ScrollView {
			VerStack {
				buildTopView(proxy: proxy)
				buildTopic()
				buildReturnToTopButton()
			}
			.padding(.top, Constants.padding)
		}
		.opacity($viewModel.loadingSucceed.wrappedValue ? 1.0 : .zero)
		.scrollIndicators(.automatic)
	}

	func buildTopic() -> some View {
		ForEach($viewModel.newsArray) { $article in
			NavigationLink {
				TopicDetail(viewModel: viewModel, article: article)
			} label: {
				TopicCell(viewModel: viewModel, article: article)
			}
		}
	}

	/// For scrolling to `top` only
	func buildTopView(proxy: ScrollViewProxy) -> some View {
		EmptyView()
			.id("top")
			.onChange(of: isNeedScrollToTop) {
				withAnimation {
					proxy.scrollTo("top", anchor: .bottom)
				}
			}
	}

	func buildReturnToTopButton() -> some View {
		ReturnCell {
			viewModel.impactOccured(.light)
			DispatchQueue.main.asyncAfter(
				deadline: .now() + 1.5,
				execute: { isNeedScrollToTop.toggle() }
			)
		}
	}
}

#Preview {
	TopicsList(viewModel: ViewModel())
}
