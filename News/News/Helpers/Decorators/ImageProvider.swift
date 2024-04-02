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
        case Category.technology.rawValue:
            "iphone.gen1.radiowaves.left.and.right"
        case Category.sports.rawValue:
            "figure.outdoor.cycle"
        case Category.science.rawValue:
            "atom"
        case Category.health.rawValue:
            "bolt.heart"
        case Category.general.rawValue:
            "list.clipboard"
        case Category.entertainment.rawValue:
            "play"
        case Category.business.rawValue:
            "brain.filled.head.profile"
        case SoundTheme.starwars.rawValue:
            "star.circle.fill"
        case SoundTheme.silentMode.rawValue:
            "powersleep"
        case SoundTheme.cats.rawValue:
            "cat.fill"
        case AdditionalInfo.contactUs.rawValue:
            "ellipsis.message"
        default:
            "info.circle.fill"
        }

        return Image(systemName: imageName)
    }
}
