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
	@State private var isRotating = false

	@State private var arrowSize: CGFloat = .zero
	@State private var arrowAngle: Angle = .zero
	@State private var arrowScale: CGFloat = .zero

	@State private var circleSize: CGFloat = .zero
	@State private var circleAngle: Angle = .zero
	@State private var circleScale: CGFloat = .zero

	@State private var initialOffset: CGFloat = .zero
	@State private var previousDiff: CGFloat = .zero

	private var seconds: Int {
		Date().getSeconds()
	}

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
		.onAppear { startRotating() }
	}
}

// MARK: - Views
private extension CustomScrollView {
	var customRefreshControl: some View {
		ZStack {
			arrow
			circle
		}
	}

	var arrow: some View {
		let icons: Set = ["🙄", "😎"]

		return ZStack {
			if seconds % 10 == .zero {
				DesignedText(text: icons.first ?? "💩")
					.font(.system(size: 34))
			} else {
				Image(systemName: "arrow.down.circle")
					.resizable()
			}
		}
		.frame(width: arrowSize, height: arrowSize)
		.scaleEffect(arrowScale)
		.rotationEffect(arrowAngle)
	}

	var circle: some View {
		let icons: Set = ["😵‍💫", "🤤"]

		return ZStack {
			if seconds % 10 == .zero {
				DesignedText(text: icons.first ?? "💩")
					.font(.system(size: 34))
			} else {
				Image(systemName: "circle.dotted")
					.resizable()
			}
		}
		.frame(
			width: circleSize,
			height: circleSize
		)
		.scaleEffect(circleScale)
		.rotationEffect(circleAngle)
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

		if diff > Constants.refreshControlSize * 2 {
			withAnimation(.bouncy(duration: 0.3)) {
				showArrow()
				refreshData()
			}
		} else if diff == Constants.refreshControlSize {
			guard isLoading else { return }
			withAnimation(.easeInOut(duration: 0.15)) {
				hideArrow()
				showCircle()
			}
		} else {
			guard !isLoading else { return }
			rotateArrowDown()
		}

		rotateArrowUp(diff)
	}

	func rotateArrowUp(_ diff: CGFloat) {
		if previousDiff > diff {
			guard !isRotating else { return }
			isRotating = true
			withAnimation {
				arrowAngle = .degrees(180)
			}
		}

		previousDiff = diff
	}

	func rotateArrowDown() {
		isRotating = false
		arrowAngle = .zero
	}
}

// MARK: - Loading
private extension CustomScrollView {
	func refreshData() {
		guard !isLoading else { return }
		isLoading = true

		viewModel.impactOccured(.rigid)
		viewModel.refresh {
			hideRefreshControl()
		}
	}

	func startRotating() {
		withAnimation(.linear(duration: 20).repeatForever(autoreverses: false)) {
			circleAngle = .degrees(360)
		}
	}

	func hideRefreshControl() {
		Task {
			isLoading = false

			withAnimation(.bouncy(duration: 0.2)) {
				hideCircle()
				hideArrow()
			}
		}
	}
}

// MARK: - Helpers
private extension CustomScrollView {
	func showArrow() {
		arrowSize = Constants.refreshControlSize
		arrowScale = 1.0
		hideCircle()
	}

	func hideArrow() {
		arrowSize = .zero
		arrowScale = .zero
	}

	func showCircle() {
		circleScale = 1.0
		circleSize = Constants.refreshControlSize
	}

	func hideCircle() {
		circleSize = .zero
		circleScale = .zero
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
