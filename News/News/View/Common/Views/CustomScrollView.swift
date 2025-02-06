//
//  CustomScrollView.swift
//  News
//
//  Created by Yaroslav Kupriyanov on 28.01.2025.
//

import SwiftUI

struct CustomScrollView<Content: View>: View {
	let content: () -> Content
	let viewModel: ViewModel

	@State private var isLoading = false
	@State private var radius: CGFloat = .zero
	@State private var circleColor: Color = .rowBackground
	@State private var circleSize: CGFloat = .zero
	@State private var initialOffset: CGFloat = .zero

	init(
		content: @escaping () -> Content,
		viewModel: ViewModel
	) {
		self.content = content
		self.viewModel = viewModel
	}

	var body: some View {
		ScrollView {
			customRefreshControl
			scrollViewContent
		}
		.coordinateSpace(name: "scroll")
		.onPreferenceChange(ScrollViewOffsetPreferenceKey.self) { value in
			onPreferenceChanged(value)
		}
	}
}

// MARK: - Views
private extension CustomScrollView {
	var customRefreshControl: some View {
		Circle()
			.fill(circleColor)
			.gloss(color: circleColor, radius: radius)
			.padding(.top, Constants.padding)
			.frame(width: circleSize, height: circleSize)
	}

	var scrollViewContent: some View {
		ZStack {
			content()
			GeometryReader { proxy in
				let offset = proxy.frame(in: .named("scroll")).minY
				Color.clear.preference(key: ScrollViewOffsetPreferenceKey.self, value: offset)
			}
		}
	}
}

// MARK: - Preference
private extension CustomScrollView {
	func onPreferenceChanged(_ value: ScrollViewOffsetPreferenceKey.Value) {
		if initialOffset == .zero { initialOffset = value }
		let diff = value - initialOffset

		if diff > Constants.refreshControlSize * 3 {
			refreshData()
		} else {
			guard !isLoading else { return }
			let size = diff / 2
			guard size > 0 else { return }
			circleSize = size
		}
	}
}

// MARK: - Loading
private extension CustomScrollView {
	func refreshData() {
		guard !isLoading else { return }
		withAnimation(.bouncy(duration: 0.3)) {
			radius = 20.0
			circleColor = viewModel.loaderShadowColor
			circleSize = Constants.refreshControlSize
			isLoading = true
			viewModel.impactOccured(.rigid)
			viewModel.refresh { hideRefreshControl() }
		}
	}

	func hideRefreshControl() {
		Task {
			isLoading = false
			withAnimation(.bouncy(duration: 0.2)) {
				circleSize = .zero
			} completion: {
				radius = .zero
				circleColor = .rowBackground
			}
		}
	}
}

// MARK: - PreferenceKey
struct ScrollViewOffsetPreferenceKey: PreferenceKey {
	static var defaultValue: CGFloat = .zero

	static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
		value = nextValue()
	}

	typealias Value = CGFloat
}
