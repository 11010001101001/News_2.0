//
//  SettingsCell.swift
//  News
//
//  Created by Ярослав Куприянов on 29.03.2024.
//

import SwiftUI

struct SettingsCell: View, ImageProvider {
    @ObservedObject var viewModel: ViewModel

    @State private var needAnimate = false

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
        .frame(height: 45)
        .contentShape(Rectangle())
        .onTapGesture {
            viewModel.applySettings(id.lowercased())
            needAnimate.toggle()
        }
        .symbolEffect(.bounce, value: needAnimate)
    }
}

#Preview {
    SettingsCell(viewModel: ViewModel(), id: Categories.business.rawValue)
}
