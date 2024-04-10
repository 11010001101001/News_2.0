//
//  InfoCell.swift
//  News
//
//  Created by Ярослав Куприянов on 02.04.2024.
//

import SwiftUI

struct InfoCell: View, ImageProvider {

    @State private var needAnimate = false

    let id: String

    var body: some View {
        HStack {
            getImage(for: id)
            Text(id.capitalizingFirstLetter())
                .font(.system(size: 18, weight: .regular))
            Spacer()
        }
        .frame(height: 40)
        .contentShape(Rectangle())
        .onAppear {
            needAnimate.toggle()
        }
        .symbolEffect(.bounce, value: needAnimate)
    }
}

#Preview {
    InfoCell(id: AdditionalInfo.appVersion.rawValue)
}
