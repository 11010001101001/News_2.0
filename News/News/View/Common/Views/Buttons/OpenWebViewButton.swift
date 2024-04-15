//
//  OpenWebViewButton.swift
//  News
//
//  Created by Ярослав Куприянов on 15.04.2024.
//

import SwiftUI

struct OpenWebViewButton: View {

    @ObservedObject var viewModel: ViewModel

    @State private var webViewPresented = false

    let data: ButtonMetaData

    var body: some View {
        CustomButton(viewModel: viewModel,
                     action: { webViewPresented.toggle() },
                     title: data.title,
                     iconName: data.iconName)
        .sheet(isPresented: $webViewPresented) {
            if let url = URL(string: data.article.url ?? .empty) {
                WebView(url: url)
            }
        }
    }
}
