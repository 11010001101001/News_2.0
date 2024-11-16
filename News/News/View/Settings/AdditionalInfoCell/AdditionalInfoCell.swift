//
//  AdditionalInfoCell.swift
//  News
//
//  Created by Yaroslav Kupriyanov on 16.11.2024.
//

import Foundation
import SwiftUI

struct AdditionalInfoCell: View {
	@ObservedObject private var viewModel: ViewModel
	
	init(viewModel: ViewModel) {
		self.viewModel = viewModel
	}
	
	var body: some View {
		Group {
			InfoCell(id: AdditionalInfo.appVersion.rawValue
					 +
					 AdditionalInfo.currentAppVersion)
			LinkCell(viewModel: viewModel,
					 id: AdditionalInfo.contactUs.rawValue,
					 link: AdditionalInfo.contactLink)
		}
	}
}
