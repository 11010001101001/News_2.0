//
//  InnerShadowAnimator.swift
//  News
//
//  Created by Ярослав Куприянов on 04.02.2025.
//

import SwiftUI

struct InnerShadowAnimator<S: Shape>: ViewModifier {
    @State private var radius: CGFloat = .zero

    private let shape: S
    private let angle: Angle
    private let colors: [Color]
    private let width: CGFloat
    private let finalX: CGFloat
    private let finalY: CGFloat
    private let isAnimationEnabled: Bool

    init(
        shape: S = .rect(cornerRadius: Constants.cornerRadius),
        angle: Angle = .degrees(.zero),
        colors: [Color] = [.blue, .purple, .red, .orange, .yellow, .purple, .blue],
        width: CGFloat = 6,
        isAnimationEnabled: Bool = false
    ) {
        self.shape = shape
        self.angle = angle
        self.colors = colors
        self.width = width
        self.isAnimationEnabled = isAnimationEnabled
        radius = isAnimationEnabled ? .zero : 2.0
        finalX = CGFloat(cos(angle.radians - .pi / 2))
        finalY = CGFloat(sin(angle.radians - .pi / 2))
    }

    func body(content: Content) -> some View {
        content
            .overlay(
                ZStack {
                    shape
                        .stroke(AngularGradient(colors: colors, center: .center), lineWidth: width)
                        .offset(x: 2, y: -1.5)
                        .blur(radius: radius * 6)
                        .mask(shape)
                    ForEach(0..<2) { _ in
                        shape
                            .stroke(AngularGradient(colors: colors, center: .center), lineWidth: width)
                            .offset(x: 2, y: -1.5)
                            .blur(radius: radius * 3)
                            .mask(shape)
                    }
                    ForEach(0..<3) { _ in
                        shape
                            .stroke(AngularGradient(colors: colors, center: .center), lineWidth: width)
                            .blur(radius: radius)
                            .mask(shape)
                    }
                }
                    .onAppear {
                        guard isAnimationEnabled else { return }
                        withAnimation(.smooth(duration: 0.4, extraBounce: 0.5)) {
                            radius = 2.0
                        }
                    }
                    .onDisappear {
                        guard isAnimationEnabled else { return }
                        radius = .zero
                    }
            )
    }
}
