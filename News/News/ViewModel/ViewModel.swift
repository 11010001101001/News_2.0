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

    @Published var newsArray: [Articles]
    @Published var loadingSucceed: Bool
    @Published var loadingFailed: Bool
    @Published var failureReason: String
    @Published var keyWord: String?

    @Published var errorSound: String
    @Published var refreshSound: String
    @Published var loadedSound: String

    @Published var feedbackStyle: UIImpactFeedbackGenerator.FeedbackStyle?
    @Published var feedBackType: UINotificationFeedbackGenerator.FeedbackType?

    @Published var cancellables: Set<AnyCancellable>

    var soundManager: SoundManager?
    var vibrateManager: VibrateManager?

    var savedSettings: [SettingsModel]?

    init(newsArray: [Articles] = [Articles](),
         loadingSucceed: Bool = false,
         loadingFailed: Bool = false,
         failureReason: String = String.empty,
         keyWord: String? = nil,
         errorSound: String = String.empty,
         refreshSound: String = String.empty,
         loadedSound: String = String.empty,
         cancellables: Set<AnyCancellable> = Set<AnyCancellable>(),
         savedSettings: [SettingsModel]? = nil,
         feedbackStyle: UIImpactFeedbackGenerator.FeedbackStyle? = nil,
         feedBackType: UINotificationFeedbackGenerator.FeedbackType? = nil)
    {
        self.newsArray = newsArray
        self.loadingSucceed = loadingSucceed
        self.loadingFailed = loadingFailed
        self.failureReason = failureReason
        self.keyWord = keyWord
        self.errorSound = errorSound
        self.refreshSound = refreshSound
        self.loadedSound = loadedSound
        self.cancellables = cancellables
        self.savedSettings = savedSettings
        self.feedbackStyle = feedbackStyle
        self.feedBackType = feedBackType

        soundManager = SoundManager(viewModel: self)
        vibrateManager = VibrateManager(viewModel: self)
    }

    deinit {
        soundManager = nil
        vibrateManager = nil
    }
}
