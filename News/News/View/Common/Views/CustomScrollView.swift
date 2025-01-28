//
//  CustomScrollView.swift
//  News
//
//  Created by Yaroslav Kupriyanov on 28.01.2025.
//

import SwiftUI

struct CustomScrollView: View {
	@State private var data: [String] = ["Item 1", "Item 2", "Item 3"]
	@State private var isLoading = false
	@State private var initialOffset: CGFloat = 0
	@State private var size: CGFloat = 0
	@State private var scale: CGFloat = 1
	@State private var angle: Angle = .zero
	@State private var previousDiff: CGFloat = 0
	@State private var isRotating = false

	var body: some View {
		ScrollView {
			Image(systemName: "arrow.down.circle.fill")
				.resizable()
				.frame(width: size, height: size)
				.scaleEffect(scale)
				.rotationEffect(angle)

			ZStack {
				VStack {
					ForEach(data, id: \.self) { item in
						Text(item)
							.padding()
					}
				}

				GeometryReader { proxy in
					let offset = proxy.frame(in: .named("scroll")).minY
					Color.clear.preference(key: ScrollViewOffsetPreferenceKey.self, value: offset)
				}
			}
		}
		.coordinateSpace(name: "scroll")
		.onPreferenceChange(ScrollViewOffsetPreferenceKey.self) { value in
			if initialOffset == .zero { initialOffset = value }
			let diff = value - initialOffset

			if diff > Constants.customRefreshControlSize {
				withAnimation(.bouncy(duration: 0.35)) {
					size = Constants.customRefreshControlSize
					scale = 1.0
				}

			} else {
				withAnimation(.bouncy(duration: 0.45)) {
					isRotating = false
					angle = .zero
					size = .zero
					scale = .zero
				}
			}

			if self.previousDiff > diff {
				guard !isRotating else { return }
				isRotating = true

				withAnimation {
					angle = .degrees(180)
				}
			}

			self.previousDiff = diff
		}
		.background(.red)
	}

	func refreshData() {
		isLoading = true
		DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
			data.append("New Item")
			isLoading = false
		}
	}
}

struct ScrollViewOffsetPreferenceKey: PreferenceKey {
	static var defaultValue: CGFloat = .zero

	static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
		value = nextValue()
	}

	typealias Value = CGFloat
}

struct CustomScrollView_Previews: PreviewProvider {
	static var previews: some View {
		CustomScrollView()
	}
}
