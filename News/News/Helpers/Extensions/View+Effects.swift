//
//  View+Effects.swift
//  News
//
//  Created by Ярослав Куприянов on 27.03.2024.
//

import Foundation
import SwiftUI

extension View {

    private var rotationCoordinates: [(x: CGFloat, y: CGFloat, z: CGFloat)] {
        var randomNumbers = [CGFloat]()

        for i in stride(from: -1.0, to: 1.0, by: 0.1) {
            randomNumbers.append(i)
        }

        let x = randomNumbers.randomElement() ?? .zero
        let y = randomNumbers.randomElement() ?? .zero
        let z = randomNumbers.randomElement() ?? .zero

        var coordinates = [(x: CGFloat, y: CGFloat, z: CGFloat)]()

        for _ in 0...10 {
            coordinates.append((x: x, y: y, z: z))
        }

        return coordinates
    }

    private var randomCoordinates: (x: CGFloat, y: CGFloat, z: CGFloat) {
        rotationCoordinates.randomElement() ?? (x: 1.0, y: 1.0, z: 0.0)
    }

    func commonScaleAffect(state: Bool) -> some View {
        return self
            .scaleEffect((state ? 1.0 : .zero) ?? .zero)
            .animation(.smooth(duration: 0.6, extraBounce: 0.3), value: state)
    }

    func applyNice3DRotation(rotating: Bool, duration: CGFloat? = 10.0) -> some View {
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
}
