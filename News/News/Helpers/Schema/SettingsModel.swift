//
//  SettingsModel.swift
//  News
//
//  Created by Ярослав Куприянов on 26.03.2024.
//

import Foundation
import SwiftData

@Model
final class SettingsModel {
    var category: String
    var soundTheme: String

    init(category: String, soundTheme: String) {
        self.category = category
        self.soundTheme = soundTheme
    }
}
