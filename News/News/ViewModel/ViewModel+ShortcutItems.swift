//
//  ViewModel+ShortcutItems.swift
//  News
//
//  Created by Ярослав Куприянов on 10.04.2024.
//

import Foundation
import UIKit

enum ShortcutItemType: String {
    case share
    case settings

    var title: String {
        switch self {
        case .share:
            return "Share app"
        case .settings:
            return "Open settings"
        }
    }
}

extension ViewModel {
    // TODO: !!!))
    func configureShortcutItems() {
        let shareItem = UIApplicationShortcutItem(type: ShortcutItemType.share.rawValue,
                                                  localizedTitle: ShortcutItemType.share.title,
                                                  localizedSubtitle: nil,
                                                  icon: UIApplicationShortcutIcon(type: .share))

        let settingsItem = UIApplicationShortcutItem(type: ShortcutItemType.settings.rawValue,
                                                     localizedTitle: ShortcutItemType.settings.title,
                                                     localizedSubtitle: nil,
                                                     icon: UIApplicationShortcutIcon(type: .update))

        UIApplication.shared.shortcutItems = [settingsItem, shareItem]
    }
}
