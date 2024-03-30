//
//  ViewModel+Settings.swift
//  News
//
//  Created by Ярослав Куприянов on 28.03.2024.
//

import Foundation

extension ViewModel {

    private(set) var soundTheme: String {
        get { savedSettings?.first?.soundTheme ?? SoundThemes.silentMode.rawValue }
        set { savedSettings?.first?.soundTheme = newValue }
    }

    private(set) var category: String {
        get { savedSettings?.first?.category ?? Categories.technology.rawValue }
        set { savedSettings?.first?.category = newValue }
    }

    func applySettings(_ name: String) {
        switch name {
        case let name where Categories.allCases.contains(where: { $0.rawValue == name }):
            guard name != category else {
                VibrateManager.shared.vibrate(.error)
                return
            }
            category = name
            loadNews()
        case let name where SoundThemes.allCases.contains(where: { $0.rawValue == name }):
            guard name != soundTheme else {
                VibrateManager.shared.vibrate(.error)
                return
            }
            soundTheme = name
            VibrateManager.shared.vibrate(.success)
            // change sound theme in sound manager
        default:
            break
        }
    }
}
