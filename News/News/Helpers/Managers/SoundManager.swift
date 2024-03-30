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

    private var randomJedySound: String {
        Set(["jedy1", "jedy2"]).randomElement() ?? ""
    }

    mutating private func playSound(soundFileName: String, soundTheme: String) {
        let soundOn = soundTheme != SoundThemes.silentMode.rawValue

        guard soundOn else { return }

        guard let urlPath = Bundle
                .main
                .path(forResource: soundFileName, ofType: "mp3") else { return }
        let url = URL(fileURLWithPath: urlPath)

        do {
            player = try AVAudioPlayer(contentsOf: url)
            player.play()
        } catch {
            fatalError("Error in playing sound...🙂")
        }
    }
}

extension SoundManager {
    mutating func playRefresh(soundTheme: String) {
        playSound(soundFileName: randomJedySound, soundTheme: soundTheme)
    }

    mutating func playLoaded(soundTheme: String) {
        playSound(soundFileName: "loaded", soundTheme: soundTheme)
    }

    mutating func playError(soundTheme: String) {
        playSound(soundFileName: "error", soundTheme: soundTheme)
    }
}
