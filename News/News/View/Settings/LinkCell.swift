//
//  LinkCell.swift
//  News
//
//  Created by Ярослав Куприянов on 02.04.2024.
//

import SwiftUI

struct LinkCell: View, ImageProvider {
	@ObservedObject var viewModel: ViewModel
    @Environment(\.openURL) private var openURL
    @State private var scale: CGFloat = 1.0

    let id: String
    let link: URL

    var body: some View {
        HStack {
            getImage(for: id)
            Text(id.capitalizingFirstLetter())
                .font(.system(size: 18, weight: .regular))
            Spacer()
        }
        .applyRowBackground()
        .frame(height: 40)
        .contentShape(Rectangle())
        .modifier(
            OnTap(
                scale: $scale,
				execute: { viewModel.impactOccured(.light) },
                completion: { openURL(link) }
            )
        )
    }
}

#Preview {
	LinkCell(
		viewModel: ViewModel(),
		id: AdditionalInfo.contactUs.rawValue,
		link: URL(string: "https://www.google.com")!
	)
}
