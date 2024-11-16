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
	@State private var rotating: Bool
	
	init(viewModel: ViewModel, article: Article, rotating: Bool = false) {
		self.viewModel = viewModel
		self.article = article
		self.rotating = rotating
	}
	
	var body: some View {
		VerStack(alignment: .center) {
			CachedAsyncImage(article: article, viewModel: viewModel)
			otherContent
		}
		.navigationTitle("Details")
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
		.card()
		.commonScaleAffect(state: rotating)
		.onAppear { rotating.toggle() }
		.ignoresSafeArea(edges: .bottom)
	}
	
	var description: some View {
		Text(article.description ?? "Loading...")
	}
	
	var buttons: some View {
		HorStack(spacing: Constants.padding) {
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
								 description: "Very long description of the topic if you really want this for testing for example i dont know what to type more here but i guess it's enough Very long description of the topic if you really want this for testing for example i dont know what to type more here but i guess it's enough",
								 publishedAt: "Time"))
	// swiftlint:enable line_length
}
