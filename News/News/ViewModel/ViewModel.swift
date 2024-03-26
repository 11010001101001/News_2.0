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

    @Published var newsArray = [Articles]()
//    = [Articles(source: Source(id: "New York Times", name: "New York Times"),
//                                                     author: "Kate Middleton",
//                                                     title: "Apple releases IOs 1000",
//                                                     description: "So far so good. Another big update from world's biggest mobile company",
//                                                     url: "www.apple.com",
//                                                     urlToImage: "www.apple.com/image.png",
//                                                     publishedAt: Date().description,
//                                                     content: "Some content",
//                                                     viewed: false)]
    @Published var cancellables = Set<AnyCancellable>()
//    @Published var errorPublisher = AnyPublisher<(() -> Void), Never>()

    private func newsPublisher(with keyWord: String? = nil, category: String? = nil) -> AnyPublisher<[Articles], any Error> {
        var urlString: String {
            let mode: Mode = keyWord == nil ? .category(category ?? "") : .keyword(keyWord ?? "")
            return getLinkWith(mode)
        }

        guard let url = URL(string: urlString) else {
            return Just([Articles]())
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }

        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { [weak self] data, response in
                let info = try JSONDecoder().decode(CommonInfo.self, from: data)
                return info.articles ?? []
//                self?.handleResponse(response as? HTTPURLResponse)
            }
//            .map { $0.data }
//            .decode(type: CommonInfo.self, decoder: JSONDecoder())
//            .map { $0.articles ?? [] }
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }

//    private func handleResponse(_ response: HTTPURLResponse?) {
//        guard let response else { return }
//        VibrateManager.shared.impactOccured(.rigid)
//        
//        switch response.statusCode {
//        case HttpStatusCodes.tooManyRequests.rawValue:
//            view?.handleResponseFailure(with: Errors.tooManyRequests.rawValue)
//        case HttpStatusCodes.internalServerError.rawValue:
//            view?.handleResponseFailure(with: Errors.serverError.rawValue)
//        case HttpStatusCodes.notFound.rawValue:
//            view?.handleResponseFailure(with: Errors.unauthorized.rawValue)
//        case HttpStatusCodes.badRequest.rawValue:
//            view?.handleResponseFailure(with: Errors.badRequest.rawValue)
//        case HttpStatusCodes.ok.rawValue:
//            view?.handleResponseSuccess()
//        default:
//            break
//        }
//    }

    func loadNews() {
        newsPublisher()
            .sink { error in
                print(error)
            } receiveValue: { [weak self] articles in
                self?.newsArray = articles
            }
            .store(in: &cancellables)
    }

//    func handleError() {
//        errorPublisher()
//            .sink { error in
//                print(error)
//            } receiveValue: { [weak self] error in
//                error
//            }
//
//    }

    //https://newsapi.org/v2/top-headlines?country=us&category=technology&pageSize=100&apiKey=8f825354e7354c71829cfb4cb15c4893
    private func getLinkWith(_ mode: Mode) -> String {
        switch mode {
        case .keyword(let keyword):
            return "https://newsapi.org/v2/everything?q=\(keyword)&pageSize=\(Constants.newsCount)&language=ru&apiKey=\(DeveloperInfo.apiKey.rawValue)"
        case .category(let category):
            return "https://newsapi.org/v2/top-headlines?country=us&category=\(category)&pageSize=\(Constants.newsCount)&apiKey=\(DeveloperInfo.apiKey.rawValue)"
        }
    }
}

private enum Constants {
    static let newsCount = "100"
}
