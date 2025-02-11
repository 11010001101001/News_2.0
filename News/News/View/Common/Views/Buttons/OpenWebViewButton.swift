//
//  OpenWebViewButton.swift
//  News
//
//  Created by Ярослав Куприянов on 15.04.2024.
//

import SwiftUI

struct OpenWebViewButton: View {
	@ObservedObject private var viewModel: ViewModel
	@ObservedObject var webViewModel = WebViewModel()

	@State private var rotating = false
	@State private var webViewPresented: Bool
	@State private var opacity = 1.0

	private let data: ButtonMetaData

	init(
		viewModel: ViewModel,
		webViewPresented: Bool = false,
		data: ButtonMetaData
	) {
		self.viewModel = viewModel
		self.webViewPresented = webViewPresented
		self.data = data
		if let url = data.article.url {
			webViewModel.url = URL(string: url)
		}
	}

	var body: some View {
		CustomButton(
			viewModel: viewModel,
			action: { webViewPresented.toggle() },
			title: data.title,
			iconName: data.iconName
		)
		.fullScreenCover(isPresented: $webViewPresented) {
			FullScreenCover(title: Texts.Screen.More.title()) {
				VerStack {
					progressView
					buildCoverContents()
				}
			}
		}
	}
}

// MARK: - Cover contents
extension OpenWebViewButton {
	func buildCoverContents() -> some View {
		ZStack {
			webView
			loader
			error
		}
	}
}

// MARK: Views
private extension OpenWebViewButton {
	var loader: some View {
		Loader(
			loaderName: viewModel.loader,
			shadowColor: viewModel.loaderShadowColor
		)
		.frame(height: Constants.imageHeight)
		.opacity(webViewModel.loadingState == .loading ? 1 : 0)
	}

	var webView: some View {
		WebView(viewModel: webViewModel)
	}

	var error: some View {
		ErrorView(viewModel: viewModel, title: Errors.loadingFailed, action: nil)
			.applyNice3DRotation(rotating: rotating)
			.commonScaleAffect(state: rotating)
			.frame(height: Constants.imageHeight)
			.onAppear { rotating.toggle() }
			.opacity(webViewModel.loadingState == .error ? 1 : 0)
	}

	var progressView: some View {
		ProgressView(value: webViewModel.progress)
			.tint(LoaderConfiguration(rawValue: viewModel.loader)?.shadowColor)
			.animation(.smooth, value: webViewModel.progress)
			.onChange(of: webViewModel.progress) { _, progress in
				guard progress == 1.0 else { return }
				DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
					withAnimation {
						opacity = .leastNonzeroMagnitude
					}
				}
			}
			.opacity(opacity)
	}
}
