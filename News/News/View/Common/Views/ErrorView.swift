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
				if let title {
					Label(title, systemImage: "bolt.fill")
						.labelStyle(.titleOnly)
						.foregroundStyle(.blue)
						.multilineTextAlignment(.center)
						.font(.headline)
						.padding(.horizontal, Constants.padding * 2)
				}

				Image(uiImage: .errorCat)
					.resizable()
					.frame(width: 150, height: 150)
					.scaledToFill()
					.padding(.horizontal)
					.shadow(color: .shadowHighlight, radius: 10)

				CustomButton(
					viewModel: viewModel,
					action: action,
					title: Texts.Actions.reload()
				)
			}
			.padding(Constants.padding)
		}
		.card()
		.ignoresSafeArea()
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
