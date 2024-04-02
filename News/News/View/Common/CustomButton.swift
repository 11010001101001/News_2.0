//
//  CustomButton.swift
//  News
//
//  Created by Ярослав Куприянов on 26.03.2024.
//

import SwiftUI

struct CustomButton: View {

    @ObservedObject var viewModel: ViewModel

    @State private var scale = 1.0

    let title: String
    let action: Action

    var body: some View {
        Button(action: {
            viewModel.impactOccured(.light)
            withAnimation(.easeInOut(duration: 0.1)) {
                scale = 0.85
            } completion: {
                withAnimation(.easeInOut(duration: 0.3)) {
                    scale = 1.0
                } completion: {
                    action?()
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
    CustomButton(viewModel: ViewModel(),
                 title: "Reload",
                 action: {})
}
