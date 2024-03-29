//
//  View+Effects.swift
//  News
//
//  Created by Ярослав Куприянов on 27.03.2024.
//

import Foundation
import SwiftUI

extension View {
    func applyScaleEffect(state: Bool, start: CGFloat? = 1.0, end: CGFloat? = .zero) -> some View {
        return self
            .scaleEffect((state ? start : end) ?? .zero)
            .animation(.smooth(duration: 0.6, extraBounce: 0.3), value: state)
    }

    func applyNice3DRotation(rotating: Bool, coordinates: (x: CGFloat, y: CGFloat, z: CGFloat)) -> some View {
        return self
            .rotation3DEffect(
                Angle(degrees: rotating ? -10 : 10),
                axis: rotating ? coordinates : coordinates,
                anchor: .center,
                anchorZ: 0.5,
                perspective: rotating ? 1 : -1
            )
            .animation(.easeInOut(duration: 10).repeatForever(autoreverses: true),
                       value: rotating)
            .applyScaleEffect(state: rotating, start: 1.0, end: .zero)
    }
}
