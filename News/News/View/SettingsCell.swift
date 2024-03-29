//
//  SettingsCell.swift
//  News
//
//  Created by Ярослав Куприянов on 29.03.2024.
//

import SwiftUI

struct SettingsCell: View, ImageProvider {
    @State private var needAnimate = false

    let id: String
    let tapped: SettingsTappedAction?

    var body: some View {
        HStack {
            getImage(for: id)
            Text(id.capitalized)
                .font(.system(size: 18, weight: .regular))
            Spacer()
        }
        .frame(height: 45)
        .contentShape(Rectangle())
        .onTapGesture {
            tapped?(id.lowercased())
            needAnimate.toggle()
        }
        .symbolEffect(.bounce, value: needAnimate)
    }
}

#Preview {
    SettingsCell(id: Categories.business.rawValue, tapped: { _ in })
}
