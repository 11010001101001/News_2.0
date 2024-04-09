//
//  ViewModel+CheckIsViewed.swift
//  News
//
//  Created by Ярослав Куприянов on 09.04.2024.
//

import Foundation

extension ViewModel {
    func checkIsViewed(_ topicTitle: String) -> Bool {
        watchedTopics.contains(where: { $0 == topicTitle })
    }

    func markAsRead(_ topicTitle: String) {
        let isViewed = checkIsViewed(topicTitle)

        guard !isViewed else { return }

        watchedTopics.append(topicTitle)
        clearStorage()
    }

    private func clearStorage() {
        guard watchedTopics.count >= Constants.storageCapacity else { return }
        watchedTopics = Array(watchedTopics.dropFirst(Constants.needDropCount))
    }
}

private enum Constants {
    static let storageCapacity = 500
    static let needDropCount = 250
}
