//
//  ViewModel+Settings.swift
//  News
//
//  Created by Ярослав Куприянов on 28.03.2024.
//

import Foundation

extension ViewModel {

    private var soundTheme: String {
        get { savedSettings?.first?.soundTheme ?? SoundThemes.starwars.rawValue }
        set { savedSettings?.first?.soundTheme = newValue }
    }

    private var category: String {
        get { savedSettings?.first?.category ?? Categories.technology.rawValue }
        set { savedSettings?.first?.category = newValue }
    }

    func applySettings(_ name: String) {
        switch name {
        case let name where Categories.allCases.contains(where: { $0.rawValue == name }):
            guard name != category else {
                VibrateManager.shared.vibrate(.warning)
                return
            }
            VibrateManager.shared.impactOccured(.light)
            category = name
            loadNews()
        case let name where SoundThemes.allCases.contains(where: { $0.rawValue == name }):
            guard name != soundTheme else {
                VibrateManager.shared.vibrate(.warning)
                return
            }
            VibrateManager.shared.impactOccured(.light)
            soundTheme = name
            // change sound theme in sound manager
        default:
            break
        }
    }
}
