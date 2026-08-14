//
//  EmojisHelper.swift
//  Tracker
//
//  Created by Nikler on 8/14/26.
//

struct EmojisHelper {
    static let emojis: [Character] = [
        "🙂", "😻", "🌺", "🐶", "❤️", "😱",
        "😇", "😡", "🥶", "🤔", "🙌", "🍔",
        "🥦", "🏓", "🥇", "🎸", "🏝", "😪"
    ]
    
    static var randomEmoji: Character {
        emojis[Int.random(in: (0..<emojis.count))]
    }
}
