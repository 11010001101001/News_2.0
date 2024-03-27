//
//  ViewModel.swift
//  News
//
//  Created by Ярослав Куприянов on 26.03.2024.
//

import Foundation
import Combine
import SwiftUI

final class ViewModel: ObservableObject {

    @Published private var cancellables = Set<AnyCancellable>()

    @Published var newsArray = [Articles]()
    @Published var loadingSucceed = false
    @Published var loadingFailed = false
    @Published var failureReason = ""
    @Published var keyWord: String?
    @Published var category: String?

    private var newsPublisher: AnyPublisher<[Articles], ApiError> {
        var urlString: String {
            let mode: Mode = keyWord == nil ? .category(category ?? Categories.technology.rawValue) : .keyword(keyWord ?? "")
            return getLinkWith(mode)
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
                    VibrateManager.shared.impactOccured(.rigid)
                    return ApiError.mappingError(msg: Errors.mappingError.rawValue)
                }
                .receive(on: RunLoop.main)
                .eraseToAnyPublisher()
        } else {
            VibrateManager.shared.impactOccured(.rigid)
            return Fail(error: ApiError.invalidRequest(msg: Errors.invalidUrl.rawValue))
                .eraseToAnyPublisher()
        }
    }

    private func handleResponse(_ response: HTTPURLResponse?) throws {
        guard let response else {
            throw ApiError.mappingError(msg: Errors.responseError.rawValue)
        }
        VibrateManager.shared.impactOccured(.rigid)

        switch response.statusCode {
        case HttpStatusCodes.tooManyRequests.rawValue:
            throw ApiError.tooManyRequests(msg: Errors.tooManyRequests.rawValue)
        case HttpStatusCodes.internalServerError.rawValue:
            throw ApiError.internalServerError(msg: Errors.serverError.rawValue)
        case HttpStatusCodes.notFound.rawValue:
            throw ApiError.notFound(msg: Errors.unauthorized.rawValue)
        case HttpStatusCodes.badRequest.rawValue:
            throw ApiError.badRequest(msg: Errors.badRequest.rawValue)
        default:
            break
        }
    }

    private func getLinkWith(_ mode: Mode) -> String {
        switch mode {
        case .keyword(let keyword):
            "https://newsapi.org/v2/everything?q=\(keyword)&pageSize=\(Constants.newsCount)&language=ru&apiKey=\(DeveloperInfo.apiKey.rawValue)"
        case .category(let category):
            "https://newsapi.org/v2/top-headlines?country=us&category=\(category)&pageSize=\(Constants.newsCount)&apiKey=\(DeveloperInfo.apiKey.rawValue)"
        }
    }
}

// MARK: - Helpers

extension ViewModel {
    func loadNews() {
        loadingSucceed = false
        loadingFailed = false

        newsPublisher
            .sink { [weak self] error in
                guard case .failure(let failure) = error else {
                    return
                }
                self?.loadingFailed = true
                self?.failureReason = failure.failureReason ?? failure.errorDescription ?? failure.localizedDescription
            } receiveValue: { [weak self] articles in
                self?.loadingSucceed = true
                self?.newsArray = articles
            }
            .store(in: &cancellables)
    }
}

private enum Constants {
    static let newsCount = "100"
}
