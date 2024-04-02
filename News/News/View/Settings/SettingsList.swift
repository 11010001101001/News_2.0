//
//  SettingsList.swift
//  News
//
//  Created by Ярослав Куприянов on 26.03.2024.
//

import SwiftUI

struct SettingsList: View {

    @ObservedObject var viewModel: ViewModel

    var body: some View {
        VStack(alignment: .leading) {
            List {
                Section(header: Text(Category.title).font(.headline)) {
                    ForEach(Category.allCases) { category in
                        SettingsCell(viewModel: viewModel, id: category.rawValue)
                    }
                }

                Section(header: Text(SoundTheme.title).font(.headline)) {
                    ForEach(SoundTheme.allCases) { theme in
                        SettingsCell(viewModel: viewModel, id: theme.rawValue)
                    }
                }
                
                Section(header: Text(AdditionalInfo.title).font(.headline)) {
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
}


#Preview {
    SettingsList(viewModel: ViewModel())
}
