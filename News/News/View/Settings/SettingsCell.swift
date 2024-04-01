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
    @State private var scale = 1.0

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
            withAnimation {
                scale = 0.95
            } completion: {
                withAnimation {
                    scale = 1.0
                }
            }
        }
        .onAppear {
            needAnimate.toggle()
        }
        .symbolEffect(.bounce, value: needAnimate)
        .scaleEffect(scale)
    }
}

#Preview {
    SettingsCell(viewModel: ViewModel(), id: Category.business.rawValue)
}
