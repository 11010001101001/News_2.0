//
//  ErrorView.swift
//  News
//
//  Created by Ярослав Куприянов on 26.03.2024.
//

import SwiftUI
import Lottie

struct ErrorView: View {

    @ObservedObject var viewModel: ViewModel

    @State private var scale = 1.0

    var title: String
    var action: Action

    var body: some View {
        ZStack {
            VStack {
                VStack {
                    Label(title, systemImage: "bolt.fill")
                        .labelStyle(.titleOnly)
                        .foregroundStyle(.blue)
                        .multilineTextAlignment(.center)
                        .font(.body)
                        .padding(EdgeInsets(top: .zero,
                                            leading: 100,
                                            bottom: .zero,
                                            trailing: 100))

                    LottieView(animation: .named("error"))
                        .playing(loopMode: .playOnce)
                        .shadow(color: .red, radius: 30)
                        .frame(width: 150, height: 100)
                        .ignoresSafeArea()
                        .scaledToFit()
                        .padding(.horizontal)
                        .scaleEffect(scale)
                        .onAppear {
                            withAnimation(.easeInOut(duration: 0.1)) {
                                scale = 2.1
                            } completion: {
                                withAnimation(.easeInOut(duration: 0.3)) {
                                    scale = 1.0
                                }
                            }
                        }
                }

                CustomButton(viewModel: viewModel,
                             action: action,
                             title: "Reload")
            }
        }
    }
}

#if DEBUG
#Preview {
    ErrorView(viewModel: ViewModel(),
              title: "Time - out\nerror\n\nServer problem or internet connection broken",
              action: {
        print("Button pressed")
    })
}
#endif
