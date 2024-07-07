//
//  SettingsTip.swift
//  News
//
//  Created by Ярослав Куприянов on 11.04.2024.
//

import SwiftUI
import TipKit

struct SettingsTip: Tip {
    var title: Text {
        Text("Tip")
    }

    var message: Text? {
        Text("Configure category, loader and sound theme 🦥")
    }

    var image: Image? {
        Image(systemName: "lightbulb.max")
    }
}
