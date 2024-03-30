//
//  SoundManager.swift
//  News
//
//  Created by Ярослав Куприянов on 30.03.2024.
//

import Foundation
import AVKit
import SwiftUI

struct SoundManager {
    static var shared = SoundManager()

    private var player = AVAudioPlayer()

    mutating private func playSound(soundFileName: String, soundTheme: String) {
        let soundOn = soundTheme != SoundTheme.silentMode.rawValue

        guard soundOn else { return }

        guard let urlPath = Bundle
                .main
                .path(forResource: soundFileName, ofType: "mp3") else { return }
        let url = URL(fileURLWithPath: urlPath)

        do {
            player = try AVAudioPlayer(contentsOf: url)
            player.prepareToPlay()
            player.play()
        } catch {
            fatalError("Error in playing sound...🙂")
        }
    }
}

extension SoundManager {
    private var starwarsRefresh: String {
        Set(["starwars_refresh", "starwars_refresh1", "starwars_refresh2"]).randomElement() ?? ""
    }
}

extension SoundManager {
    mutating func playRefresh(soundTheme: String) {
        let name = switch soundTheme {
        case SoundTheme.starwars.rawValue:
            starwarsRefresh
        case SoundTheme.cats.rawValue:
            "cats_refresh"
        default:
            String.empty
        }
        playSound(soundFileName: name, soundTheme: soundTheme)
    }

    mutating func playLoaded(soundTheme: String) {
        let name = switch soundTheme {
        case SoundTheme.starwars.rawValue:
            "starwars_loaded"
        case SoundTheme.cats.rawValue:
            "cats_loaded"
        default:
            String.empty
        }
        playSound(soundFileName: name, soundTheme: soundTheme)
    }

    mutating func playError(soundTheme: String) {
        let name = switch soundTheme {
        case SoundTheme.starwars.rawValue:
            "starwars_error"
        case SoundTheme.cats.rawValue:
            "cats_error"
        default:
            String.empty
        }
        playSound(soundFileName: name, soundTheme: soundTheme)
    }
}
