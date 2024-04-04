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
        Button(action: { buttonAction?() },
               label: { Label(title: { titleView },
                              icon: { iconView })
        })
        .buttonStyle(.bordered)
        .clipShape(.capsule(style: .continuous))
        .controlSize(.regular)
        .opacity(action == nil ? .zero : 1.0)
        .scaleEffect(scale)
    }

    private var buttonAction: Action {
        {
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
        }
    }

    private var titleView: some View {
        Group {
            if title == nil {
                EmptyView()
            } else {
                Text(title ?? .empty)
                    .foregroundStyle(.blue)
            }
        }
    }

    private var iconView: some View {
        iconName == nil
        ? nil
        : Image(systemName: iconName!)
    }
}

#Preview {
    CustomButton(viewModel: ViewModel(),
                 action: {},
                 title: "Tap me",
                 iconName: "square.and.arrow.down.on.square")
}
