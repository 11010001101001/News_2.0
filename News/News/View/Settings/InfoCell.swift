//
//  InfoCell.swift
//  News
//
//  Created by Ярослав Куприянов on 02.04.2024.
//

import SwiftUI

struct InfoCell: View, ImageProvider {
    let id: String

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
    }
}

#Preview {
    InfoCell(id: AdditionalInfo.appVersion.rawValue)
}
