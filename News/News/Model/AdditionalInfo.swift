//
//  AdditionalInfo.swift
//  News
//
//  Created by Ярослав Куприянов on 02.04.2024.
//

import Foundation

enum AdditionalInfo: String, CaseIterable, Identifiable {
    var id: Self { return self }

    static var currentAppVersion: String {
        Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "Error in recognizing appVersion"
    }

    static var title: String { "Info" }
    static var tabItemImage: String { "info.circle" }

    static let contactLink = URL(string: "https://t.me/Yaroslav_Kupriyanov")!

    case appVersion = "app version: "
    case contactUs = "contact us"
}
