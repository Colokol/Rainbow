//
//  GameConfig.swift
//  Rainbow
//
//  Created by Uladzislau Yatskevich on 16.11.23.
//

import Foundation

struct GameConfig {
    let levelTime :Int
    let wordChangeSpeed: Int
    let backgroundActive: Bool

    init(config: (Int,Int,Bool)){
        levelTime = config.0
        wordChangeSpeed = config.1
        backgroundActive = config.2
    }
}
