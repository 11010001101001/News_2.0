//
//  WebView.swift
//  News
//
//  Created by Ярослав Куприянов on 15.04.2024.
//

import Foundation
import WebKit
import SwiftUI

final class WebViewModel: ObservableObject {
	@Published var url: URL?
	@Published var loadingState: LoadingState = .loading

	init(url: URL? = nil) {
		self.url = url
	}
}

struct WebView: UIViewRepresentable {
	@ObservedObject var viewModel: WebViewModel

	func makeUIView(context: Context) -> some WKWebView {
		let webView = WKWebView()
		if let url = viewModel.url {
			let request = URLRequest(url: url)
			webView.load(request)
		}
		webView.navigationDelegate = context.coordinator
		return webView
	}

	func updateUIView(_ webView: UIViewType, context: UIViewRepresentableContext<WebView>) {
		return
	}

	func makeCoordinator() -> WKWebViewCoordinator {
		WKWebViewCoordinator(viewModel)
	}
}

// MARK: Coordinator
extension WebView {
	final class WKWebViewCoordinator: NSObject, WKNavigationDelegate, ObservableObject {
		private var viewModel: WebViewModel

		init(_ viewModel: WebViewModel) {
			self.viewModel = viewModel
		}

		func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
			viewModel.loadingState = .loaded
		}

		func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
			viewModel.loadingState = .error
		}

		func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
			viewModel.loadingState = .loaded
		}

		func webView(
			_ webView: WKWebView,
			didFailProvisionalNavigation navigation: WKNavigation!,
			withError error: any Error
		) {
			viewModel.loadingState = .error
		}
	}
}
