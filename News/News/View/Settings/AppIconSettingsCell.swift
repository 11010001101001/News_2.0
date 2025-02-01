//
//  LoaderSettingsCell.swift
//  News
//
//  Created by Ярослав Куприянов on 04.04.2024.
//

import SwiftUI
import Lottie

struct AppIconSettingsCell: View {
    @ObservedObject private var viewModel: ViewModel
    private let id: String

	init(viewModel: ViewModel, id: String) {
		self.viewModel = viewModel
		self.id = id
	}

    var body: some View {
        ZStack {
            HorStack {
				Image(id)
					.resizable()
					.frame(width: 100, height: 100)
					.clipShape(.capsule)
					.padding()

                Spacer()
            }

			HorStack {
                DesignedText(text: id.capitalizingFirstLetter())
                    .font(.system(size: 18, weight: .regular))
                    .padding(.leading, 140)

                Spacer()
            }
        }
        .card()
        .applyOrNotSettingsModifier(
            isEnabled: viewModel.checkIsEnabled(id.lowercased())
        ) {
            viewModel.applySettings(id.lowercased())
        }
		.markIsSelected(viewModel, id, .shadowHighlight)
    }
}

#Preview {
	AppIconSettingsCell(viewModel: ViewModel(), id: AppIconConfiguration.globe.rawValue)
}
