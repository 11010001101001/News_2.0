//
//  OnTap.swift
//  News
//
//  Created by Ярослав Куприянов on 08.07.2024.
//

import SwiftUI

struct OnTap: ViewModifier {
    @Binding var scale: CGFloat
    var execute: Action?
    var completion: Action?

    func body(content: Content) -> some View {
        content
            .scaleEffect(scale)
            .onTapGesture {
                execute??()
                withAnimation(.easeInOut(duration: 0.1)) {
                    scale = 0.98
                } completion: {
                    withAnimation(.easeInOut(duration: 0.15)) {
                        scale = 1.0
                    } completion: {
                        completion??()
                    }
                }
            }
    }
}
