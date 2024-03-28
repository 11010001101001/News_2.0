//
//  Settings.swift
//  News
//
//  Created by Ярослав Куприянов on 26.03.2024.
//

import SwiftUI

struct Settings: View, ImageCellProvider {
    var tapped: SettingsTappedAction?

    var body: some View {
        VStack(alignment: .leading) {
            List {
                Section(header: Text(Categories.title)) {
                    ForEach(Categories.allCases) { category in
                        getImageCell(id: category.rawValue, tapped: tapped)
                    }
                }

                Section(header: Text(SoundThemes.title)) {
                    ForEach(SoundThemes.allCases) { category in
                        getImageCell(id: category.rawValue, tapped: tapped)
                    }
                }
            }
        }
    }
}


#Preview {
    Settings { setting in
        print("tapped \(setting)")
    }
}
