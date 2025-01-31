//
//  ErrorView.swift
//  News
//
//  Created by Ярослав Куприянов on 26.03.2024.
//

import SwiftUI
import Lottie

struct ErrorView: View {
	@ObservedObject private var viewModel: ViewModel
	private var title: String?
	private let action: Action

	init(
		viewModel: ViewModel,
		title: String? = nil,
		action: Action
	) {
		self.viewModel = viewModel
		self.title = title
		self.action = action
	}

	var body: some View {
		VerStack(alignment: .center) {
			Group {
				errorTitle
				errorImage
				reloadButton
			}
			.padding(Constants.padding)
		}
		.card()
		.shadow(color: .shadowHighlight, radius: 10.0)
		.ignoresSafeArea()
	}
}

// MARK: - Private
private extension ErrorView {
	var errorTitle: some View {
		ConditionalView(title != nil) {
			Label(title ?? .empty, systemImage: "bolt.fill")
				.labelStyle(.titleOnly)
				.foregroundStyle(.blue)
				.multilineTextAlignment(.center)
				.font(.headline)
				.padding(.horizontal, CGFloat.sideInsets)
		}
	}

	var errorImage: some View {
		Image(uiImage: .errorCat)
			.resizable()
			.frame(width: 150, height: 150)
			.scaledToFill()
			.padding(.horizontal)
			.shadow(color: .shadowHighlight, radius: 10)
	}

	var reloadButton: some View {
		CustomButton(
			viewModel: viewModel,
			action: action,
			title: Texts.Actions.reload()
		)
	}
}

#if DEBUG
#Preview {
	ErrorView(viewModel: ViewModel(),
			  title: "Time - out\nerror\n\nServer problem or internet connection broken",
			  action: {
		print("Button pressed")
	})
}
#endif
