//
//  LinkCell.swift
//  News
//
//  Created by Ярослав Куприянов on 02.04.2024.
//

import SwiftUI

struct LinkCell: View, ImageProvider {
    @Environment(\.openURL) private var openURL
    @State private var needAnimate = false
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
        .applyBackground()
        .frame(height: 40)
        .contentShape(Rectangle())
        .modifier(
            OnTap(
                scale: $scale,
                execute: { needAnimate.toggle() },
                completion: { openURL(link) }
            )
        )
        .onAppear { needAnimate.toggle() }
        .symbolEffect(.bounce, value: needAnimate)
        .scaleEffect(scale)
    }
}

#Preview {
    LinkCell(id: AdditionalInfo.contactUs.rawValue,
             link: URL(string: "https://www.google.com")!)
}
