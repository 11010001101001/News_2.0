//
//  Categories.swift
//  News
//
//  Created by Ярослав Куприянов on 27.03.2024.
//

import Foundation

enum Categories: String, CaseIterable, Identifiable {
    var id: Self { return self }
    static var title: String { "Please choose news category" }
    static var key: String { String(describing: self) }

    case business
    case entertainment
    case general
    case health
    case science
    case sports
    case technology
}
