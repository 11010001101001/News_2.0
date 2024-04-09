//
//  ViewModel.swift
//  News
//
//  Created by Ярослав Куприянов on 26.03.2024.
//

import Foundation
import Combine
import SwiftUI
import SwiftData

final class ViewModel: ObservableObject {

    @Published var newsArray = [Article]()
    @Published var loadingSucceed = false
    @Published var loadingFailed = false
    @Published var failureReason = String.empty
    /// For redraw loader on content view after settings loaded: render loader -> settings loaded -> redraw
    @Published var id: Int?
    @Published var keyWord: String?

    @Published var errorSound = String.empty
    @Published var refreshSound = String.empty
    @Published var loadedSound = String.empty
    @Published var notificationSound = String.empty

    @Published var feedbackStyle: UIImpactFeedbackGenerator.FeedbackStyle?
    @Published var feedBackType: UINotificationFeedbackGenerator.FeedbackType?

    @Published var cancellables = Set<AnyCancellable>()

    var soundManager: SoundManager?
    var vibrateManager: VibrateManager?
    var notificationManager: NotificationManager?

    var savedSettings: [SettingsModel]?

    init(savedSettings: [SettingsModel]? = nil) {
        soundManager = SoundManager(viewModel: self)
        vibrateManager = VibrateManager(viewModel: self)
        notificationManager = NotificationManager(viewModel: self)
    }

    deinit {
        soundManager = nil
        vibrateManager = nil
        notificationManager = nil
    }
}
