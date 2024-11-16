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
    @State private var scale: CGFloat
    private let id: String

	init(
		viewModel: ViewModel,
		scale: CGFloat = 1.0,
		id: String
	) {
		self.viewModel = viewModel
		self.scale = scale
		self.id = id
	}
	
    var body: some View {
        ZStack {
            HorStack {
                LottieView(animation: .named(id))
                    .playing(loopMode: .loop)
                    .shadow(color: LoaderConfiguration(rawValue: id)?.shadowColor ?? .clear,
                            radius: 20)
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
            isEnabled: viewModel.checkIsEnabled(id.lowercased()),
            scale: $scale
        ) {
            viewModel.applySettings(id.lowercased())
        }
		.markIsSelected(viewModel, id)
    }
}

#Preview {
    LoaderSettingsCell(viewModel: ViewModel(), id: LoaderConfiguration.rocket.rawValue)
}
