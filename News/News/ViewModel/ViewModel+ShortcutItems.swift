//
//  ViewModel+ShortcutItems.swift
//  News
//
//  Created by Ярослав Куприянов on 11.04.2024.
//

import Foundation
import UIKit

extension ViewModel {
    func addShortcutItems() {
        UIApplication.shared.shortcutItems = ShortcutItem.allItems
    }

    func handleShortcutItemTap(_ name: String) {
        switch name {
        case ShortcutItem.settings.rawValue:
            print("settings tapped!")
        case ShortcutItem.share.rawValue:
            print("share tapped")
        default:
            break
        }
    }
}
