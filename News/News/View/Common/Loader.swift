//
//  Loader.swift
//  News
//
//  Created by Ярослав Куприянов on 31.03.2024.
//

import SwiftUI
import Lottie
import Combine

struct Loader: View {

    @State private var scale = 0.4

    private let loaderName: String
    private let shadowColor: Color

    init(loaderName: String, shadowColor: Color) {
        self.loaderName = loaderName
        self.shadowColor = shadowColor
    }

    var body: some View {
        LottieView(animation: .named(loaderName))
            .playing(loopMode: .loop)
            .scaleEffect(scale)
            .onAppear {
                withAnimation(.easeInOut(duration: 0.1)) {
                    scale = 0.5
                } completion: {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        scale = 0.4
                    }
                }
            }
            .shadow(color: shadowColor, radius: 40)
    }
}

#Preview {
    Loader(loaderName: "Test", shadowColor: .red)
}
