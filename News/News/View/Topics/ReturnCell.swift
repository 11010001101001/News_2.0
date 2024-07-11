//
//  ReturnCell.swift
//  News
//
//  Created by Ярослав Куприянов on 03.04.2024.
//

import SwiftUI
import Lottie

struct ReturnCell: View {
    @State private var scale = 1.0
    let action: Action

    var body: some View {
        HStack {
            Spacer()

            Text("That's all. Return?")
                .font(.headline)
                .padding(.leading)

            LottieButton(animation: .named("button"), action: action ?? {})
                .frame(width: 100, height: 80)
                .shadow(color: .white, radius: 10)
                .scaleEffect(scale)
                .padding(.trailing)

            Spacer()
        }
        .onAppear {
            withAnimation(.bouncy(duration: 0.1)) {
                scale = 1.1
            } completion: {
                withAnimation(.bouncy(duration: 0.2, extraBounce: 0.3)) {
                    scale = 1.0
                }
            }
        }
    }
}

#Preview {
    ReturnCell(action: {})
}
