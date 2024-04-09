//
//  NewsWidgetsBundle.swift
//  NewsWidgets
//
//  Created by Ярослав Куприянов on 05.04.2024.
//

import WidgetKit
import SwiftUI

@main
struct NewsWidgetsBundle: WidgetBundle {
    var body: some Widget {
        NewsWidgets()
        NewsWidgetsLiveActivity()
    }
}
