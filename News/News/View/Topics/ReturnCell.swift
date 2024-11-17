//
//  ReturnCell.swift
//  News
//
//  Created by Ярослав Куприянов on 03.04.2024.
//

import SwiftUI
import Lottie

struct ReturnCell: View {
	private let action: Action

	init(action: Action) {
		self.action = action
	}

	var body: some View {
		HorStack {
			Text(Texts.Actions.Return.message())
				.font(.headline)
				.padding(.leading)

			LottieButton(animation: .named("button"), action: action ?? {})
				.frame(width: 100, height: 80)
				.shadow(color: .white, radius: 7)
				.padding(.trailing)
		}
	}
}

#Preview {
	ReturnCell(action: {})
}
