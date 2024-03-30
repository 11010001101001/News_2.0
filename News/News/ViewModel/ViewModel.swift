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

    @Published var newsArray = [Articles]()
    @Published var loadingSucceed = false
    @Published var loadingFailed = false
    @Published var failureReason = String.empty
    @Published var keyWord: String?
    @Published var cancellables = Set<AnyCancellable>()

    var savedSettings: [SettingsModel]?

    var newsPublisher: AnyPublisher<[Articles], ApiError> {
        var urlString: String {
            let mode: Mode = keyWord == nil ? .category(category) : .keyword(keyWord ?? .empty)
            return switch mode {
            case .keyword(let keyword):
                "https://newsapi.org/v2/everything?q=\(keyword)&pageSize=\(Constants.newsCount)&language=ru&apiKey=\(DeveloperInfo.apiKey.rawValue)"
            case .category(let category):
                "https://newsapi.org/v2/top-headlines?country=us&category=\(category)&pageSize=\(Constants.newsCount)&apiKey=\(DeveloperInfo.apiKey.rawValue)"
            }
        }

        if let url = URL(string: urlString) {
            return URLSession.shared.dataTaskPublisher(for: url)
                .retry(3)
                .tryMap { [weak self] data, response in
                    let info = try JSONDecoder().decode(CommonInfo.self, from: data)
                    try self?.handleResponse(response as? HTTPURLResponse)
                    return info.articles ?? []
                }
                .mapError { error in
                    ApiError.mappingError(msg: Errors.mappingError.rawValue)
                }
                .receive(on: RunLoop.main)
                .eraseToAnyPublisher()
        } else {
            return Fail(error: ApiError.invalidRequest(msg: Errors.invalidUrl.rawValue))
                .eraseToAnyPublisher()
        }
    }
}

private enum Constants {
    static let newsCount = "100"
}
