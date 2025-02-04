//
//  View+Extensions.swift
//  News
//
//  Created by Ярослав Куприянов on 27.03.2024.
//

import Foundation
import SwiftUI

// swiftlint:disable large_tuple
extension View {
    private var rotationCoordinates: [(x: CGFloat, y: CGFloat, z: CGFloat)] {
        var randomNumbers = [CGFloat]()

        for num in stride(from: -1.0, to: 1.0, by: 0.1) {
            randomNumbers.append(num)
        }

        let randomX = randomNumbers.randomElement() ?? .zero
        let randomY = randomNumbers.randomElement() ?? .zero
        let randomZ = randomNumbers.randomElement() ?? .zero

        var coordinates = [(x: CGFloat, y: CGFloat, z: CGFloat)]()

        for _ in 0...10 {
            coordinates.append((x: randomX,
                                y: randomY,
                                z: randomZ))
        }

        return coordinates
    }

    private var randomCoordinates: (x: CGFloat, y: CGFloat, z: CGFloat) {
        rotationCoordinates.randomElement() ?? (x: 1.0, y: 1.0, z: 0.0)
    }

    func commonScaleAffect(state: Bool) -> some View {
        return self
            .scaleEffect((state ? 1.0 : .zero) ?? .zero)
            .animation(.smooth(duration: 0.3, extraBounce: 0.4), value: state)
    }

    func applyNice3DRotation(rotating: Bool, duration: CGFloat? = 30.0) -> some View {
        return self
            .rotation3DEffect(
                Angle(degrees: rotating ? -10 : 10),
                axis: rotating ? randomCoordinates : randomCoordinates,
                anchor: .center,
                anchorZ: 0.5,
                perspective: rotating ? 1 : -1
            )
            .animation(.easeInOut(duration: duration ?? .zero).repeatForever(autoreverses: true),
                       value: rotating)
    }

    func card() -> some View {
        self
            .background(.rowBackground)
            .clipShape(RoundedRectangle(cornerRadius: Constants.cornerRadius, style: .continuous))
    }

    func any() -> AnyView {
        AnyView(self)
    }

    func applyOrNotSettingsModifier(
        isEnabled: Bool,
        execute: Action
    ) -> some View {
        isEnabled ?
        self.modifier(AnswerNegative(execute: execute)).any() :
        self.modifier(OnTap(execute: nil, completion: execute)).any()
    }

    func markAsReadOrHighlight(
        _ viewModel: ViewModel,
        _ article: Article
    ) -> some View {
        let isRead = viewModel.checkIsRead(article.key)
        let opacity = isRead ? 0.5 : 1.0
        let isShadowEnabled = (article.title?.lowercased() ?? .empty).contains("apple")

        return switch (isRead, isShadowEnabled) {
        case (false, false):
            self.any()
        case (true, false):
            self.opacity(opacity).any()
        case (true, true):
            self.opacity(opacity).any()
        case (false, true):
            if isShadowEnabled {
                self.innerShadow().any()
            } else {
                self.any()
            }
        }
    }

    func markIsSelected(
        _ viewModel: ViewModel,
        _ id: String
    ) -> some View {
        let isEnabled = viewModel.checkIsEnabled(id.lowercased())
        guard isEnabled else { return self.any() }
        return self.innerShadow().any()
    }

    func gloss(
        isEnabled: Bool = true,
        color: Color = .shadowHighlight,
        radius: CGFloat = 10.0,
        numberOfLayers: Int = 4
    ) -> some View {
        guard isEnabled else { return self.any() }

        return self
            .overlay {
                ForEach(0..<numberOfLayers) { _ in
                    self
                        .shadow(
                            color: color,
                            radius: radius
                        )
                }
            }
            .any()
    }

    func shadow_(
        isEnabled: Bool = true,
        color: Color = .shadowHighlight,
        radius: CGFloat = 10.0
    ) -> some View {
        guard isEnabled else { return self.any() }

        return self
            .shadow(
                color: color,
                radius: radius
            )
            .any()
    }

    func innerShadow<S: Shape>(
        using shape: S = .rect(cornerRadius: Constants.cornerRadius),
        angle: Angle = .degrees(.zero),
        colors: [Color] = [.blue, .purple, .red, .orange, .yellow, .purple, .blue],
        width: CGFloat = 6,
        radius: CGFloat = 2
    ) -> some View {
        let finalX = CGFloat(cos(angle.radians - .pi / 2))
        let finalY = CGFloat(sin(angle.radians - .pi / 2))

        return self
            .overlay(
                ZStack {
                    shape
                        .stroke(AngularGradient(colors: colors, center: .center), lineWidth: width)
                        .offset(x: finalX * width * 0.6, y: finalY * width * 0.6)
                        .blur(radius: radius * 6)
                        .mask(shape)
                    ForEach(0..<2) { _ in
                        shape
                            .stroke(AngularGradient(colors: colors, center: .center), lineWidth: width)
                            .offset(x: finalX * width * 0.6, y: finalY * width * 0.6)
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
            )
    }
}
// swiftlint:enable large_tuple
