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
                withAnimation(.easeInOut(duration: 0.1)) {
                    scale = 0.4
                } completion: {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        scale = 0.3
                    }
                }
            }
            .shadow(color: .blue, radius: 40)
    }
}

#Preview {
    Loader()
}
