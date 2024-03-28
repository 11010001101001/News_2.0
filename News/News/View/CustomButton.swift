//
//  CustomButton.swift
//  News
//
//  Created by Ярослав Куприянов on 26.03.2024.
//

import SwiftUI

struct CustomButton: View {

    @State private var tapped = false

    let title: String
    let action: Action

    var body: some View {
        Button(action: {
            VibrateManager.shared.impactOccured(.light)
            action?()
            withAnimation {
                tapped.toggle()
            } completion: {
                withAnimation {
                    tapped.toggle()
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
        .scaleEffect(tapped ? 0.93 : 1.0)
        .animation(.bouncy(duration: 0.2), value: tapped)
    }
}

#Preview {
    CustomButton(title: "Reload", action: {})
}
