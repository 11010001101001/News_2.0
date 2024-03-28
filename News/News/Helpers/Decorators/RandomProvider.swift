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
        let random = CGFloat((-1...1).randomElement() ?? .zero)
        var coordinates = [(x: CGFloat, y: CGFloat, z: CGFloat)]()

        for _ in 0...10 {
            coordinates.append((x: random, y: random, z: random))
        }

        return coordinates
    }

    var randomCoordinates: (x: CGFloat, y: CGFloat, z: CGFloat) {
        rotationCoordinates.randomElement() ?? (x: 1.0, y: 1.0, z: 0.0)
    }
}
