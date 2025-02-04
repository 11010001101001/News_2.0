//
//  String+Extensions.swift
//  News
//
//  Created by Ярослав Куприянов on 26.03.2024.
//

import Foundation

extension String {
    static let empty = ""
    static let spacer = " "

    func toReadableDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.locale = Locale(identifier: "en_En")

        let date = dateFormatter.date(from: self)
        dateFormatter.dateFormat = "MMM d, h:mm a"

        return dateFormatter.string(from: date!)
    }

    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + self.lowercased().dropFirst()
    }

    func getDate() -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.locale = Locale(identifier: "en_En")
        return dateFormatter.date(from: self) ?? Date()
    }
}

extension Optional where Wrapped == String {
	func orEmpty(_ defaultValue: String) -> String {
		if let self, self.isEmpty {
			return defaultValue
		}
		return self ?? defaultValue
	}
}
