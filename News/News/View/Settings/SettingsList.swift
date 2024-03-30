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
                Section(header: Text(Category.title)) {
                    ForEach(Category.allCases) { category in
                        SettingsCell(viewModel: viewModel, id: category.rawValue)
                    }
                }

                Section(header: Text(SoundTheme.title)) {
                    ForEach(SoundTheme.allCases) { theme in
                        SettingsCell(viewModel: viewModel, id: theme.rawValue)
                    }
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
