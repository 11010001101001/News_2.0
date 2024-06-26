//
//  Errors.swift
//  News
//
//  Created by Ярослав Куприянов on 26.03.2024.
//

import Foundation

enum ApiError: LocalizedError {
    case invalidRequest(msg: String)
    case tooManyRequests(msg: String)
    case internalServerError(msg: String)
    case notFound(msg: String)
    case badRequest(msg: String)
    case mappingError(msg: String)
    case undefined(msg: String)
}

enum Errors: String {
    case topicLabelNoInfo = "No description. It's not an error, press button below for more"
    case badRequest = "Error 400\n\nBad request, please try again later"
    case unauthorized = "Error 401\n\nRequest autorization failed, please try again later"
    case tooManyRequests = "Error 429\n\nRequests number per day exceeded, see you tommorow"
    case serverError = "Error 500\n\nServer error, please try again later"
    case timeout = "Time - out\nerror\n\nServer problem or internet connection broken"
    case mappingError
    case invalidUrl
    case responseError
    case undefinedError
}
