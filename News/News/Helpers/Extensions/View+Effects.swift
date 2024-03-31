//
//  View+Effects.swift
//  News
//
//  Created by Ярослав Куприянов on 27.03.2024.
//

import Foundation
import SwiftUI

extension View {
    func applyNice3DRotation(rotating: Bool,
                             duration: CGFloat? = 10.0,
                             coordinates: (x: CGFloat, y: CGFloat, z: CGFloat)) -> some View {
        return self
            .rotation3DEffect(
                Angle(degrees: rotating ? -10 : 10),
                axis: rotating ? coordinates : coordinates,
                anchor: .center,
                anchorZ: 0.5,
                perspective: rotating ? 1 : -1
            )
            .animation(.easeInOut(duration: duration ?? .zero).repeatForever(autoreverses: true),
                       value: rotating)
            .scaleEffect((rotating ? 1.0 : .zero) ?? .zero)
            .animation(.smooth(duration: 0.6, extraBounce: 0.3), value: rotating)
    }
}
