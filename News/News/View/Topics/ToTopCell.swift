//
//  ToTopCell.swift
//  News
//
//  Created by Ярослав Куприянов on 03.04.2024.
//

import SwiftUI
import Lottie

struct ToTopCell: View {
    @ObservedObject var viewModel: ViewModel

    let action: Action

    var body: some View {
        HStack {
            Spacer()
            Spacer()
            Text("Need return?")
                .padding(.leading)

            ZStack {
                LottieButton(animation: .named("button"), action: {
                    action?()
                })
                .frame(height: 150)
            }
            Spacer()
        }
    }
}

#Preview {
    ToTopCell(viewModel: ViewModel(), action: {})
}
