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
	@State private var scale: CGFloat
	private var title: String?
	private let action: Action
	
	init(
		viewModel: ViewModel,
		scale: Double = 1.0,
		title: String? = nil,
		action: Action
	) {
		self.viewModel = viewModel
		self.scale = scale
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
				
				LottieView(animation: .named("error"))
					.playing(loopMode: .playOnce)
					.shadow(color: .red, radius: 30)
					.frame(width: 200, height: 150)
					.ignoresSafeArea()
					.scaledToFit()
					.padding(.horizontal)
					.scaleEffect(scale)
					.onAppear {
						withAnimation(.easeInOut(duration: 0.1)) {
							scale = 2.1
						} completion: {
							withAnimation(.easeInOut(duration: 0.3)) {
								scale = 1.0
							}
						}
					}
				
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
