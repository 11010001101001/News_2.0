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
	var newsPublisher: AnyPublisher<(data: Data, response: URLResponse), any Error> {
		var urlString: String {
			let mode: Mode = keyWord == nil ? .category(category) : .keyword(keyWord ?? .empty)
			return switch mode {
			case .keyword(let keyword):
				"https://newsapi.org/v2/everything?q=\(keyword)&pageSize=\(Constants.newsCount)&language=ru&apiKey=\(DeveloperInfo.apiKey)"
			case .category(let category):
				"https://newsapi.org/v2/top-headlines?country=us&category=\(category)&pageSize=\(Constants.newsCount)&apiKey=\(DeveloperInfo.apiKey)"
			}
		}
		// swiftlint:enable line_length

		guard let url = URL(string: urlString) else {
			return Fail(error: ApiError.invalidRequest(msg: Errors.invalidUrl))
				.eraseToAnyPublisher()
		}

		return URLSession.shared.dataTaskPublisher(for: url)
			.retry(3)
			.mapError { _ in ApiError.mappingError(msg: Errors.mappingError) }
			.receive(on: RunLoop.main)
			.eraseToAnyPublisher()
	}
}

// MARK: - Logic
extension ViewModel {
	func loadNews() {
		loadingSucceed = false
		loadingFailed = false

		newsPublisher
			.sink { _ in } receiveValue: { [weak self] value in self?.handleResponse(value)}
			.store(in: &cancellables)
	}
}

// MARK: - Private
private extension ViewModel {
	func handleResponse(_ value: (data: Data, response: URLResponse)) {
		guard let response = value.response as? HTTPURLResponse,
			  let model = try? JSONDecoder().decode(CommonInfo.self, from: value.data)
		else { return }

		let statusCode = response.statusCode

		switch statusCode {
		case 200:
			notificationOccurred(.success)
			playLoaded()
			loadingSucceed = true
			newsArray = model.articles?.filter { !($0.title ?? .empty).contains("Removed") } ?? []
		default:
			notificationOccurred(.error)
			playError()
			loadingFailed = true
			failureReason = HttpStatusCodes(rawValue: statusCode)?.message ?? .empty
		}
	}
}
