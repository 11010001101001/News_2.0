//
//  ReturnCell.swift
//  News
//
//  Created by Ярослав Куприянов on 03.04.2024.
//

import SwiftUI
import Lottie

struct ReturnCell: View {

    @State private var animateGradient = false
    @State private var scale = 1.0

    let action: Action

    var body: some View {
        HStack {
            Spacer()
            Spacer()
            Text("Need return?")
                .font(.headline)
                .padding(.leading)

            LottieButton(animation: .named("button"), action: action ?? {})
                .frame(height: 150)
                .scaleEffect(scale)
        }
        .background {
            LinearGradient(colors: [.cyan, .purple, .red, .orange],
                           startPoint: animateGradient ? .leading : .bottom,
                           endPoint: animateGradient ? .bottom : .trailing)
            .ignoresSafeArea()
            .blur(radius: 2)
        }
        .onAppear {
            Task {
                withAnimation(.bouncy(duration: 0.1)) {
                    scale = 1.03
                } completion: {
                    withAnimation(.bouncy(duration: 0.2)) {
                        scale = 1.0
                    } completion: {
                        withAnimation(.smooth(duration: 3)) {
                            animateGradient.toggle()
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    ReturnCell(action: {})
}
