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

    let action: Action
    var title: String?
    var iconName: String?

    var body: some View {
        Button(action: {
            viewModel.impactOccured(.light)
            withAnimation(.easeInOut(duration: 0.1)) {
                scale = 0.9
            } completion: {
                withAnimation(.easeInOut(duration: 0.3)) {
                    scale = 1.0
                } completion: {
                    action?()
                }
            }
        }, label: {
            Label(
                title: {
                    if title == nil {
                        EmptyView()
                    } else {
                        Text(title ?? .empty)
                            .fontDesign(.monospaced)
                            .foregroundStyle(.blue)
                    }
                },
                icon: { iconName == nil ? nil : Image(systemName: iconName!) }
            )
        })
        .buttonStyle(.bordered)
        .clipShape(.capsule(style: .continuous))
        .controlSize(.regular)
        .opacity(action == nil ? .zero : 1.0)
        .scaleEffect(scale)
    }
}

#Preview {
    CustomButton(viewModel: ViewModel(),
                 action: {},
                 title: nil,
                 iconName: "square.and.arrow.down.on.square")
}
