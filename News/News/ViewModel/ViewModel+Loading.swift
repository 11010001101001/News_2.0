//
//  ViewModel+Loading.swift
//  News
//
//  Created by Ярослав Куприянов on 28.03.2024.
//

import Foundation

extension ViewModel {
    func loadNews() {
        loadingSucceed = false
        loadingFailed = false

        newsPublisher
            .sink { [weak self] error in
                guard case .failure(let failure) = error else {
                    return
                }
                // playSound
                VibrateManager.shared.impactOccured(.rigid)
                self?.loadingFailed = true
                self?.failureReason = failure.failureReason ?? failure.errorDescription ?? failure.localizedDescription
            } receiveValue: { [weak self] articles in
                // playSound
                VibrateManager.shared.impactOccured(.soft)
                self?.loadingSucceed = true
                self?.newsArray = articles
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
