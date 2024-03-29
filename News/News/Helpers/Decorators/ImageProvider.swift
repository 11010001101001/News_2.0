//
//  ImageProvider.swift
//  News
//
//  Created by Ярослав Куприянов on 28.03.2024.
//

import Foundation
import SwiftUI

protocol ImageProvider {}

extension ImageProvider {
    func getImage(for settingName: String) -> some View {
        let imageName = switch settingName {
        case Categories.technology.rawValue:
            "iphone.gen1.radiowaves.left.and.right"
        case Categories.sports.rawValue:
            "figure.outdoor.cycle"
        case Categories.science.rawValue:
            "atom"
        case Categories.health.rawValue:
            "bolt.heart"
        case Categories.general.rawValue:
            "list.clipboard"
        case Categories.entertainment.rawValue:
            "play"
        case Categories.business.rawValue:
            "brain.filled.head.profile"
        case SoundThemes.starwars.rawValue:
            "star.circle.fill"
        default:
            "gear"
        }

        return Image(systemName: imageName)
    }
}
