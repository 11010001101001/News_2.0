//
//  CustomButton.swift
//  News
//
//  Created by Ярослав Куприянов on 26.03.2024.
//

import SwiftUI

struct CustomButton: View {

    @State private var scale = 1.0

    let title: String
    let action: Action

    var body: some View {
        Button(action: {
            VibrateManager.shared.impactOccured(.light)
            action?()
            withAnimation {
                scale = 0.85
            } completion: {
                withAnimation {
                    scale = 1.0
                }
            }
        }, label: {
            Text(title)
                .fontDesign(.monospaced)
                .foregroundStyle(.gray)
        })
        .buttonStyle(.bordered)
        .clipShape(.capsule(style: .circular))
        .controlSize(.large)
        .opacity(action == nil ? .zero : 1.0)
        .scaleEffect(scale)
    }
}

#Preview {
    CustomButton(title: "Reload", action: {})
}
