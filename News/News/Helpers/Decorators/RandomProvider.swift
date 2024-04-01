//
//  RandomProvider.swift
//  News
//
//  Created by Ярослав Куприянов on 28.03.2024.
//

import Foundation

protocol RandomProvider { }

extension RandomProvider {
    private var rotationCoordinates: [(x: CGFloat, y: CGFloat, z: CGFloat)] {
        var randomNumbers = [CGFloat]()

        for i in stride(from: 0.0, to: 1.0, by: 0.1) {
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

    var randomCoordinates: (x: CGFloat, y: CGFloat, z: CGFloat) {
        rotationCoordinates.randomElement() ?? (x: 1.0, y: 1.0, z: 0.0)
    }
}
