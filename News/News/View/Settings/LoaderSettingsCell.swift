//
//  LoaderSettingsCell.swift
//  News
//
//  Created by Ярослав Куприянов on 04.04.2024.
//

import SwiftUI
import Lottie

struct LoaderSettingsCell: View {
    @ObservedObject var viewModel: ViewModel
    @State private var needAnimate = false
    @State private var scale: CGFloat = 1.0

    let id: String

    var body: some View {
        ZStack {
            HStack {
                LottieView(animation: .named(id))
                    .playing(loopMode: .loop)
                    .shadow(color: LoaderConfiguration(rawValue: id)?.shadowColor ?? .clear,
                            radius: 20)
                    .frame(width: 150, height: 100)
                    .padding(.leading, -40)

                Spacer()
            }

            HStack {
                Text(id.capitalizingFirstLetter())
                    .font(.system(size: 18, weight: .regular))
                    .padding(.leading, 80)

                Spacer()

                CheckMark()
                    .opacity(viewModel.loader == id ? 1.0 : .zero)
            }
        }
        .applyRowBackground()
        .frame(height: 100)
        .contentShape(Rectangle())
        .applyConditionalModifier(
            isEnabled: viewModel.checkIsEnabled(id.lowercased()),
            scale: $scale
        ) {
            viewModel.applySettings(id.lowercased())
        }
        .onAppear { needAnimate.toggle() }
        .scaleEffect(scale)
    }
}

#Preview {
    LoaderSettingsCell(viewModel: ViewModel(), id: LoaderConfiguration.rocket.rawValue)
}
