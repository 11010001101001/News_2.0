//
//  View+Extensions.swift
//  News
//
//  Created by Ярослав Куприянов on 27.03.2024.
//

import Foundation
import SwiftUI

extension View {
	func commonScaleAffect(state: Bool) -> some View {
		return self
			.scaleEffect((state ? 1.0 : .zero) ?? .zero)
			.animation(.smooth(duration: 0.3, extraBounce: 0.4), value: state)
	}

	func applyNice3DRotation(rotating: Bool, duration: CGFloat? = 30.0) -> some View {
		return self
			.rotation3DEffect(
				Angle(degrees: rotating ? -10 : 10),
				axis: rotating ? CGFloat.randomCoordinates : CGFloat.randomCoordinates,
				anchor: .center,
				anchorZ: 0.5,
				perspective: rotating ? 1 : -1
			)
			.animation(.easeInOut(duration: duration ?? .zero).repeatForever(autoreverses: true),
					   value: rotating)
	}

	func card() -> some View {
		self
			.background(.rowBackground)
			.clipShape(RoundedRectangle(cornerRadius: Constants.cornerRadius, style: .continuous))
	}

	func any() -> AnyView {
		AnyView(self)
	}

	func applyOrNotSettingsModifier(
		isEnabled: Bool,
		execute: Action
	) -> some View {
		isEnabled ?
		self.modifier(AnswerNegative(execute: execute)).any() :
		self.modifier(OnTap(execute: nil, completion: execute)).any()
	}

	func markAsReadOrHighlight(
		_ viewModel: ViewModel,
		_ article: Article
	) -> some View {
		let isRead = viewModel.checkIsRead(article.key)
		let opacity = isRead ? 0.5 : 1.0
		let isShadowEnabled = (article.title?.lowercased() ?? .empty).contains("apple")

		return switch (isRead, isShadowEnabled) {
		case (false, false):
			self.any()
		case (true, false):
			self.opacity(opacity).any()
		case (true, true):
			self.opacity(opacity).any()
		case (false, true):
			if isShadowEnabled {
				self.modifier(InnerShadowProvider()).any()
			} else {
				self.any()
			}
		}
	}

	func markIsSelected(
		_ viewModel: ViewModel,
		_ id: String
	) -> some View {
		let isEnabled = viewModel.checkIsEnabled(id.lowercased())
		guard isEnabled else { return self.any() }
		return self.modifier(InnerShadowProvider(isAnimationEnabled: true)).any()
	}

	func gloss(
		isEnabled: Bool = true,
		color: Color = .shadowHighlight,
		radius: CGFloat = 10.0,
		numberOfLayers: Int = 4,
		isBorderHighlighted: Bool = false
	) -> some View {
		guard isEnabled else { return self.any() }

		return self
			.overlay {
				ZStack {
					ForEach(0..<numberOfLayers) { _ in
						self
							.shadow(
								color: color,
								radius: radius
							)
					}

					ConditionalView(isBorderHighlighted) {
						ForEach(0..<5) { _ in
							self
								.shadow(
									color: .white,
									radius: 2
								)
						}
					}
				}
			}
			.any()
	}
}
