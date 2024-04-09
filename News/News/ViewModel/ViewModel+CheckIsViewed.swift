//
//  ViewModel+CheckIsViewed.swift
//  News
//
//  Created by Ярослав Куприянов on 09.04.2024.
//

import Foundation

extension ViewModel {
    func checkIsViewed(_ key: String) -> Bool {
        watchedTopics.contains(where: { $0 == key })
    }

    func markAsRead(_ key: String) {
        let isViewed = checkIsViewed(key)

        guard !isViewed else { return }

        watchedTopics.append(key)
        clearStorage()
    }

    private func clearStorage() {
        guard watchedTopics.count >= Constants.storageCapacity else { return }
        watchedTopics = Array(watchedTopics.dropFirst(Constants.needDropCount))
    }
}
