//
//  NotificationManager.swift
//  News
//
//  Created by Ярослав Куприянов on 09.04.2024.
//

import Foundation
import Combine
import UIKit

final class NotificationManager {
    private var notificationCancellable: AnyCancellable?

    init(viewModel: ViewModel) {
        notificationCancellable = viewModel.$notificationSound
            .sink { [weak self] sound in
                self?.configureNotifications(with: sound)
            }
    }

    /// e.g. sound theme can change - plan it again during every app launch
    private func configureNotifications(with sound: String) {
        let notificationCenter = UNUserNotificationCenter.current()

        notificationCenter.removeAllPendingNotificationRequests()

        notificationCenter.getPendingNotificationRequests { requests in
            guard requests.isEmpty else { return }

            let options: UNAuthorizationOptions = [.alert, .badge, .carPlay, .providesAppNotificationSettings, .sound]

            notificationCenter.requestAuthorization(options: options) { granted, error in
                guard error == nil, granted else { return }

                let content = UNMutableNotificationContent()
                content.title = "Mmmmm nice-ey"
                content.body = "News carriage arrived, unload please 🧸"
                content.sound = UNNotificationSound(named: UNNotificationSoundName(rawValue: "\(sound).mp3"))

                var dateComponents = DateComponents()
                dateComponents.weekday = 6
                dateComponents.hour = 17

                let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)

                let uuid = UUID().uuidString
                let request = UNNotificationRequest(identifier: uuid,
                                                    content: content,
                                                    trigger: trigger)

                notificationCenter.add(request)
            }
        }
    }
}
