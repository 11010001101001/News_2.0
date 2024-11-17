//
//  SettingsList.swift
//  News
//
//  Created by Ярослав Куприянов on 26.03.2024.
//

import SwiftUI
import Lottie

struct SettingsList: View {
	@ObservedObject private var viewModel: ViewModel

	init(viewModel: ViewModel) {
		self.viewModel = viewModel
	}

	var body: some View {
		TabView {
			buildTabItem(
				title: LoaderConfiguration.title,
				imageName: LoaderConfiguration.tabItemImage
			) {
				ForEach(LoaderConfiguration.allCases) { loader in
					LoaderSettingsCell(viewModel: viewModel, id: loader.rawValue)
				}
			}

			buildTabItem(
				title: Category.title,
				imageName: Category.tabItemImage
			) {
				ForEach(Category.allCases) { category in
					SettingsCell(viewModel: viewModel, id: category.rawValue)
				}
			}

			buildTabItem(
				title: SoundTheme.title,
				imageName: SoundTheme.tabItemImage
			) {
				ForEach(SoundTheme.allCases) { theme in
					SettingsCell(viewModel: viewModel, id: theme.rawValue)
				}
			}

			buildTabItem(
				title: AdditionalInfo.title,
				imageName: AdditionalInfo.tabItemImage
			) {
				AdditionalInfoCell(viewModel: viewModel)
			}
		}
		.indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
		.navigationTitle(Texts.Screen.Settings.title())
		.scrollIndicators(.automatic)
	}
}

// MARK: - Private
extension SettingsList {
	func buildTabItem(
		title: String,
		imageName: String,
		content: @escaping () -> some View
	) -> some View {
		ScrollView {
			VerStack(spacing: Constants.padding) {
				content()
			}
			.padding([.top, .horizontal], Constants.padding)
		}
		.tabItem {
			VerStack {
				Image(systemName: imageName).padding(.bottom, 8)
				Text(title).font(.callout)
			}
		}
	}
}

#Preview {
	SettingsList(viewModel: ViewModel())
}
