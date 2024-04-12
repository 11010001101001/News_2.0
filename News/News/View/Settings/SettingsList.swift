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
        TabView {
            getTabItem(title: LoaderConfiguration.title, imageName: LoaderConfiguration.tabItemImage) {
                ForEach(LoaderConfiguration.allCases) { loader in
                    LoaderSettingsCell(viewModel: viewModel, id: loader.rawValue)
                }
            }

            getTabItem(title: Category.title, imageName: Category.tabItemImage) {
                ForEach(Category.allCases) { category in
                    SettingsCell(viewModel: viewModel, id: category.rawValue)
                }
            }

            getTabItem(title: SoundTheme.title, imageName: SoundTheme.tabItemImage) {
                ForEach(SoundTheme.allCases) { theme in
                    SettingsCell(viewModel: viewModel, id: theme.rawValue)
                }
            }

            getTabItem(title: AdditionalInfo.title, imageName: AdditionalInfo.tabItemImage) {
                Group {
                    InfoCell(id: AdditionalInfo.appVersion.rawValue
                             +
                             AdditionalInfo.currentAppVersion)
                    LinkCell(id: AdditionalInfo.contactUs.rawValue,
                             link: AdditionalInfo.contactLink)
                }
            }
        }
        .listStyle(.plain)
        .tabViewStyle(.page)
        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
        .navigationTitle("Settings")
    }

    private func getTabItem(title: String,
                            imageName: String,
                            content: () -> some View) -> some View {
        VStack(alignment: .leading) {
            List {
                Section(header: getSectionTitle(title)) {
                    content()
                }
            }
        }
        .tabItem { Image(systemName: imageName) }
    }

    private func getSectionTitle(_ title: String) -> some View {
        HStack {
            Text(title).font(.headline)
            Spacer()
        }
        .padding(.bottom)
    }
}

#Preview {
    SettingsList(viewModel: ViewModel())
}
