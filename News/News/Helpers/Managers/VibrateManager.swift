//
//  VibrateManager.swift
//  News
//
//  Created by Ярослав Куприянов on 26.03.2024.
//

import Foundation
import UIKit

struct VibrateManager {
    static let shared = VibrateManager()

    func impactOccured(_ style: UIImpactFeedbackGenerator.FeedbackStyle) {
        UIImpactFeedbackGenerator().prepare()
        UIImpactFeedbackGenerator(style: style).impactOccurred()
    }

    func vibrate(_ feedBackType: UINotificationFeedbackGenerator.FeedbackType) {
        UINotificationFeedbackGenerator().prepare()
        UINotificationFeedbackGenerator().notificationOccurred(feedBackType)
    }
}
