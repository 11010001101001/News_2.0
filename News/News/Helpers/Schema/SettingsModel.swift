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
    var loader: String
	var appIcon: String
    var watchedTopics: [String]?

    init(
		category: String,
		soundTheme: String,
		loader: String,
		appIcon: String
	) {
        self.category = category
        self.soundTheme = soundTheme
        self.loader = loader
		self.appIcon = appIcon
    }
}

// MARK: - Equatable
extension SettingsModel: Equatable {
	static func == (lhs: SettingsModel, rhs: SettingsModel) -> Bool {
		lhs.category == rhs.category &&
		lhs.soundTheme == rhs.soundTheme &&
		lhs.loader == rhs.loader &&
		lhs.appIcon == rhs.appIcon &&
		lhs.watchedTopics == rhs.watchedTopics
	}
}
