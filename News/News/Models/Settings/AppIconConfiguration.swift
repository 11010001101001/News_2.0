//
//  AppIcon.swift
//  News
//
//  Created by Ярослав Куприянов on 01.02.2025.
//

import Foundation

enum AppIconConfiguration: String, CaseIterable, Identifiable {
    var id: Self { return self }

	static var title: String { "App icon" }

	case globe
	case sсull
    case jinx

	var iconName: String {
		return switch self {
		case .globe: "GlobeIcon"
		case .sсull: "ScullIcon"
		case .jinx: "JinxIcon"
		}
	}
}
