//
//  LoaderConfiguration.swift
//  News
//
//  Created by Ярослав Куприянов on 04.04.2024.
//

import Foundation
import SwiftUI

enum LoaderConfiguration: String, CaseIterable, Identifiable {
    var id: Self { return self }

    static var title: String { "Loader" }
    static var tabItemImage: String { "hourglass" }

    case rocket
    case hourGlass = "hourglass"
    case astronaut
    case hamster
    case cat

    var shadowColor: Color {
        switch self {
        case .rocket:
            return .orange
        case .hourGlass:
            return .cyan
        case .astronaut:
            return .red
        case .hamster:
            return .blue
        case .cat:
            return .yellow
        }
    }
}
