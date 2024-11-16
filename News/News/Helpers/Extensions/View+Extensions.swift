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

    func applyBackground() -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 26)
                .fill(.rowBackground)
                .padding(-15)

            self
        }
    }

    func any() -> AnyView {
        AnyView(self)
    }

    func applyConditionalModifier(
        isEnabled: Bool,
        scale: Binding<CGFloat>,
        execute: Action
    ) -> some View {
        isEnabled ?
        self.modifier(AnswerNegative(execute: execute)).any() :
        self.modifier(OnTap(scale: scale, execute: execute)).any()
    }
}
// swiftlint:enable large_tuple
