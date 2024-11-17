//
//  Shadow.swift
//  News
//
//  Created by Yaroslav Kupriyanov on 16.11.2024.
//

import Foundation
import SwiftUI

struct Shadow: ViewModifier {
	private let isEnabled: Bool
	private let color: Color?

	init(
		isEnabled: Bool,
		color: Color? = nil
	) {
		self.isEnabled = isEnabled
		self.color = color
	}

	func body(content: Content) -> some View {
		guard isEnabled else { return content.any() }
		return content.shadow(
			color: color ?? .shadowHighlight,
			radius: isEnabled ? 15.0 : .zero
		).any()
	}
}
