//
//  ViewModel+Loading.swift
//  News
//
//  Created by Ярослав Куприянов on 28.03.2024.
//

import Foundation
import Combine

// MARK: - Publisher

extension ViewModel {
    // swiftlint:disable line_length
    var newsPublisher: AnyPublisher<[Article], ApiError> {
        var urlString: String {
            let mode: Mode = keyWord == nil ? .category(category) : .keyword(keyWord ?? .empty)
            return switch mode {
            case .keyword(let keyword):

                "https://newsapi.org/v2/everything?q=\(keyword)&pageSize=\(Constants.newsCount)&language=ru&apiKey=\(DeveloperInfo.apiKey.rawValue)"
            case .category(let category):
                "https://newsapi.org/v2/top-headlines?country=us&category=\(category)&pageSize=\(Constants.newsCount)&apiKey=\(DeveloperInfo.apiKey.rawValue)"
            }
        }
        // swiftlint:enable line_length

        if let url = URL(string: urlString) {
            return URLSession.shared.dataTaskPublisher(for: url)
                .retry(3)
                .tryMap { [weak self] data, response in
                    let info = try JSONDecoder().decode(CommonInfo.self, from: data)
                    try self?.handleResponse(response as? HTTPURLResponse)
                    return info.articles ?? []
                }
                .mapError { _ in
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

// MARK: - Logic

extension ViewModel {

    private func cancelErrors() {
        loadingSucceed = false
        loadingFailed = false
    }

    func loadNews() {
        cancelErrors()

        newsPublisher
            .sink { [weak self] error in
                guard let self, case .failure(let failure) = error else { return }
                notificationOccurred(.error)
                playError()
                loadingFailed = true
                failureReason = failure.failureReason ?? failure.errorDescription ?? failure.localizedDescription
            } receiveValue: { [weak self] articles in
                guard let self else { return }
                notificationOccurred(.success)
                playLoaded()
                loadingSucceed = true
                newsArray = articles
            }
            .store(in: &cancellables)
    }

    func handleResponse(_ response: HTTPURLResponse?) throws {
        guard let response else {
            throw ApiError.mappingError(msg: Errors.responseError.rawValue)
        }

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
}
