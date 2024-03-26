//
//  HttpStatusCodes.swift
//  News
//
//  Created by Ярослав Куприянов on 26.03.2024.
//

import Foundation

enum HttpStatusCodes: Int {
    case badRequest = 400
    case internalServerError = 500
    case notFound = 401
    case ok = 200
    case tooManyRequests = 429
}
