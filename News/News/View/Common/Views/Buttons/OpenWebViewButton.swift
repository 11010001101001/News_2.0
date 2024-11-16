//
//  OpenWebViewButton.swift
//  News
//
//  Created by Ярослав Куприянов on 15.04.2024.
//

import SwiftUI

struct OpenWebViewButton: View {
	@ObservedObject private var viewModel: ViewModel
	@State private var webViewPresented: Bool
	private let data: ButtonMetaData
	
	init(viewModel: ViewModel,
		 webViewPresented: Bool = false,
		 data: ButtonMetaData
	) {
		self.viewModel = viewModel
		self.webViewPresented = webViewPresented
		self.data = data
	}
	
	var body: some View {
		CustomButton(
			viewModel: viewModel,
			action: { webViewPresented.toggle() },
			title: data.title,
			iconName: data.iconName
		)
		.sheet(isPresented: $webViewPresented) {
			if let url = URL(string: data.article.url ?? .empty) {
				WebView(url: url)
			}
		}
	}
}
