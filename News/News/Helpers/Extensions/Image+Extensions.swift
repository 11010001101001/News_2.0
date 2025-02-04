//
//  Image+Extensions.swift
//  News
//
//  Created by Ярослав Куприянов on 05.07.2024.
//

import SwiftUI

extension Image {
    @MainActor
    func makeRounded(height: CGFloat) -> some View {
		self
			.resizable()
			.aspectRatio(contentMode: .fill)
			.frame(width: CGFloat.screenWidth - 32,
				   height: height,
				   alignment: .center)
			.clipped()
			.clipShape(.buttonBorder)
			.shadow_(color: Color(self.averageColor), radius: 60)
	}
}
