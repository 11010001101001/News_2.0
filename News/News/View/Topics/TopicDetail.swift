//
//  Topic.swift
//  News
//
//  Created by Ярослав Куприянов on 26.03.2024.
//

import SwiftUI
import UIKit

struct TopicDetail: View {
	@ObservedObject private var viewModel: ViewModel
	private let article: Article
	
	init(viewModel: ViewModel, article: Article) {
		self.viewModel = viewModel
		self.article = article
	}
	
	var body: some View {
		ZStack {
			VerStack(alignment: .center) {
				Spacer()
				otherContent
			}
			.ignoresSafeArea(edges: .bottom)
			VerStack(alignment: .center) {
				CachedAsyncImage(article: article, viewModel: viewModel)
				Spacer()
			}
		}
		.navigationTitle(Texts.Screen.Details.title())
	}
}

// MARK: - Private
private extension TopicDetail {
	var otherContent: some View {
		VerStack {
			description
			buttons
				.padding(.vertical, Constants.padding)
			Spacer()
		}
		.padding([.top, .horizontal])
		.frame(height: CGFloat.screenHeight / 2)
		.card()
	}
	
	var description: some View {
		Text(article.description ?? Texts.State.loading())
	}
	
	var buttons: some View {
		HorStack(spacing: Constants.padding / 2) {
			ShareButton(viewModel: viewModel,
						data: ButtonMetaData(article: article,
											 title: Texts.Actions.share(),
											 iconName: "square.and.arrow.up"))
			OpenWebViewButton(viewModel: viewModel,
							  data: ButtonMetaData(article: article,
												   title: Texts.Actions.open(),
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
								 description: "Very long description of the topic if you really want this for testing for example i dont know what to type more here but i guess it's enough Very long description of the topic if you really want this for testing for example i dont know what to type more here but i guess it's enough",
								 publishedAt: "Time"))
	// swiftlint:enable line_length
}
