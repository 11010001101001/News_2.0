//
//  Loader.swift
//  News
//
//  Created by Ярослав Куприянов on 31.03.2024.
//

import SwiftUI
import Lottie

struct Loader: View {
    @State var scale = 0.3

    var body: some View {
        LottieView(animation: .named("sandClock"))
            .playing(loopMode: .loop)
            .scaleEffect(scale)
            .onAppear {
                withAnimation(.bouncy.repeatForever(autoreverses: true)) {
                    scale = 0.4
                } completion: {
                    withAnimation(.snappy) {
                        scale = 0.3
                    }
                }
            }
            .shadow(color: .blue, radius: 70)
    }
}

#Preview {
    Loader()
}
