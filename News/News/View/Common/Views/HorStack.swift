//
//  HorStack.swift
//  News
//
//  Created by Yaroslav Kupriyanov on 16.11.2024.
//

import Foundation
import SwiftUI

public struct HorStack<Content: View>: View {
	public let alignment: VerticalAlignment
	public let content: () -> Content
	public let spacing: CGFloat?
	
	public init(
		alignment: VerticalAlignment = .center,
		spacing: CGFloat = .zero,
		@ViewBuilder content: @escaping () -> Content
	) {
		self.alignment = alignment
		self.content = content
		self.spacing = spacing
	}
	
	public var body: some View {
		HStack(alignment: alignment, spacing: spacing) {
			content()
		}
	}
}