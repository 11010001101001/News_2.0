//
//  LoaderSettingsCell.swift
//  News
//
//  Created by Ярослав Куприянов on 04.04.2024.
//

import SwiftUI
import Lottie

struct LoaderSettingsCell: View {
    @ObservedObject private var viewModel: ViewModel
    private let id: String

	private var shadowColor: Color {
		LoaderConfiguration(rawValue: id)?.shadowColor ?? .shadowHighlight
	}

	init(viewModel: ViewModel, id: String) {
		self.viewModel = viewModel
		self.id = id
	}

    var body: some View {
        ZStack {
            HorStack {
                LottieView(animation: .named(id))
                    .playing(loopMode: .loop)
                    .shadow(color: shadowColor, radius: 20)
                    .frame(width: 150, height: 100)
                    .padding(.leading, -20)

                Spacer()
            }

			HorStack {
                Text(id.capitalizingFirstLetter())
                    .font(.system(size: 18, weight: .regular))
                    .padding(.leading, 100)

                Spacer()
            }
        }
        .card()
        .applyOrNotSettingsModifier(
            isEnabled: viewModel.checkIsEnabled(id.lowercased())
        ) {
            viewModel.applySettings(id.lowercased())
        }
		.markIsSelected(viewModel, id, shadowColor)
    }
}

#Preview {
    LoaderSettingsCell(viewModel: ViewModel(), id: LoaderConfiguration.rocket.rawValue)
}
