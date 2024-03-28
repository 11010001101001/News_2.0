//
//  View+Effects.swift
//  News
//
//  Created by Ярослав Куприянов on 27.03.2024.
//

import Foundation
import SwiftUI

extension View {
    func applyNice3DRotation(rotating: inout Bool, coordinates: (x: CGFloat, y: CGFloat, z: CGFloat)) -> some View {
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
            .scaleEffect(rotating ? 1 : 0)
            .animation(.smooth(duration: 1.2,
                               extraBounce: 0.3),
                       value: rotating)
    }
}
