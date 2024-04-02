//
//  AdditionalInfo.swift
//  News
//
//  Created by Ярослав Куприянов on 02.04.2024.
//

import Foundation

enum AdditionalInfo: String, CaseIterable, Identifiable {
    var id: Self { return self }

    static let currentAppVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "Error in recognizing appVersion"

    static var title: String { "Additional info" }

    case appVersion = "app version: "
}
