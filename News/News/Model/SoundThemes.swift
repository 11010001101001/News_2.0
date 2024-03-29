//
//  SoundThemes.swift
//  News
//
//  Created by Ярослав Куприянов on 28.03.2024.
//

import Foundation

enum SoundThemes: String, CaseIterable, Identifiable {
    var id: Self { return self }
    static var title: String { String(describing: self) }

    case starwars = "Star wars"
    case silentMode = "Silent mode"
}
