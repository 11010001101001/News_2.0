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
		.shadow_()
		.ignoresSafeArea()
	}
}

// MARK: - Private
private extension ErrorView {
	var errorTitle: some View {
		ConditionalView(title != nil) {
			DesignedText(text: title ?? .empty)
				.labelStyle(.titleOnly)
				.foregroundStyle(.blue)
				.multilineTextAlignment(.center)
				.font(.headline)
				.fixedSize(horizontal: false, vertical: true)
				.padding(.horizontal, CGFloat.sideInsets)
		}
	}

	var errorImage: some View {
		Image(uiImage: .errorCat)
			.resizable()
			.frame(width: 150, height: 150)
			.scaledToFill()
			.padding(.horizontal)
			.gloss()
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
