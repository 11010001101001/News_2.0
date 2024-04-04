//
//  SettingsList.swift
//  News
//
//  Created by Ярослав Куприянов on 26.03.2024.
//

import SwiftUI
import Lottie

struct SettingsList: View {

    @ObservedObject var viewModel: ViewModel

    var body: some View {
        VStack(alignment: .leading) {
            List {
                Section(header: getSectionTitle(LoaderConfiguration.title)) {
                    ForEach(LoaderConfiguration.allCases) { loader in
                        LoaderSettingsCell(viewModel: viewModel, id: loader.rawValue)
                    }
                }

                Section(header: getSectionTitle(Category.title)) {
                    ForEach(Category.allCases) { category in
                        SettingsCell(viewModel: viewModel, id: category.rawValue)
                    }
                }

                Section(header: getSectionTitle(SoundTheme.title)) {
                    ForEach(SoundTheme.allCases) { theme in
                        SettingsCell(viewModel: viewModel, id: theme.rawValue)
                    }
                }
                Section(header: getSectionTitle(AdditionalInfo.title)) {
                    InfoCell(id: AdditionalInfo.appVersion.rawValue
                             +
                             AdditionalInfo.currentAppVersion)
                    LinkCell(id: AdditionalInfo.contactUs.rawValue,
                             link: AdditionalInfo.contactLink)
                }
            }
            .listStyle(.plain)
            .navigationTitle("Settings")
        }
    }

    private func getSectionTitle(_ title: String) -> some View {
        Text(title).font(.headline)
    }
}

#Preview {
    SettingsList(viewModel: ViewModel())
}
