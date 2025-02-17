//
//  AnswerNegative.swift
//  News
//
//  Created by Ярослав Куприянов on 12.07.2024.
//

import SwiftUI

struct AnswerNegative: ViewModifier {
	let execute: Action
	@State private var left = false
	@State private var right = false
	@State private var isInitial = false
	@State private var isAnimating = false

	func body(content: Content) -> some View {
		content
			.offset(x: left ? -5 : 0)
			.offset(x: right ? 10 : 0)
			.offset(x: isInitial ? -5 : 0)
			.onTapGesture {
				guard !isAnimating else { return }
				isAnimating = true
				withAnimation { left.toggle() }
				completion: {
					withAnimation { right.toggle() }
					completion: {
						execute?()
						withAnimation(
							.interpolatingSpring(
								stiffness: 1000,
								damping: 10
							)
						) {
							isInitial.toggle()
						} completion: {
							isAnimating = false
						}
					}
				}
			}
	}
}

#Preview {
	Circle()
		.frame(width: 100, height: 100, alignment: .center)
		.modifier(AnswerNegative(execute: {}))
}
