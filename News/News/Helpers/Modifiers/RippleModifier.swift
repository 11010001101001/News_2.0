//
//  RippleModifier.swift
//  News
//
//  Created by Yaroslav Kupriyanov on 17.02.2025.
//

import SwiftUI

struct RippleModifier: ViewModifier {
	var origin: CGPoint
	var elapsedTime: TimeInterval
	var duration: TimeInterval
	var amplitude: Double
	var frequency: Double
	var decay: Double
	var speed: Double

	func body(content: Content) -> some View {
		let shader = ShaderLibrary.ripple(
			.float2(origin),
			.float(elapsedTime),

			// Parameters
			.float(amplitude),
			.float(frequency),
			.float(decay),
			.float(speed)
		)

		let maxSampleOffset = maxSampleOffset
		let elapsedTime = elapsedTime
		let duration = duration

		content.visualEffect { view, _ in
			view.layerEffect(
				shader,
				maxSampleOffset: maxSampleOffset,
				isEnabled: 0 < elapsedTime && elapsedTime < duration
			)
		}
	}

	var maxSampleOffset: CGSize {
		CGSize(width: amplitude, height: amplitude)
	}
}
