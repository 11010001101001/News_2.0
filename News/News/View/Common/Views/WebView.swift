//
//  WebView.swift
//  News
//
//  Created by Ярослав Куприянов on 15.04.2024.
//

import Foundation
import WebKit
import SwiftUI

struct WebView: UIViewRepresentable {
    private let url: URL

	init(url: URL) {
		self.url = url
	}

    func makeUIView(context: Context) -> some WKWebView {
        WKWebView()
    }

    func updateUIView(_ webView: UIViewType, context: Context) {
        let request = URLRequest(url: url)
        webView.load(request)
    }
}
