//
//  SettingsCell.swift
//  News
//
//  Created by Ярослав Куприянов on 29.03.2024.
//

import SwiftUI

struct SettingsCell: View, ImageProvider {
    @ObservedObject var viewModel: ViewModel
//    @State private var needAnimate = false
    @State private var scale: CGFloat = 1.0

    let id: String

    var body: some View {
        HStack {
            getImage(for: id)
            Text(id.capitalizingFirstLetter())
                .font(.system(size: 18, weight: .regular))
            Spacer()
            CheckMark()
                .opacity((viewModel.category == id || viewModel.soundTheme == id) ? 1.0 : .zero)
        }
        .applyRowBackground()
        .frame(height: 40)
        .contentShape(Rectangle())
        .applyConditionalModifier(
            isEnabled: viewModel.checkIsEnabled(id.lowercased()),
            scale: $scale
        ) {
            viewModel.applySettings(id.lowercased())
        }
//		.modifier(
//			OnTap(
//				scale: $scale,
//				execute: nil,
//				completion: { viewModel.applySettings(id.lowercased()) }
//			)
//		)
//        .onAppear { needAnimate.toggle() }
//        .scaleEffect(scale)
    }
}

#Preview {
    SettingsCell(viewModel: ViewModel(), id: Category.business.rawValue)
}
