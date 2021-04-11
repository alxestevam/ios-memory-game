//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Alexandre Estevam on 06/04/21.
//

import Foundation

class EmojiMemoryGame: ObservableObject {
    @Published private var model: MemoryGame<String>
    
    init(memoryGame: MemoryGame<String>) {
        model = memoryGame
    }
    
    func startNewGame(numberOfPairOfCards: Int, emojis: [String]) {
        model = EmojiMemoryGame.createMemoryGame(numberOfPairOfCards: numberOfPairOfCards, emojis: emojis)
    }
    
    private static func createMemoryGame(numberOfPairOfCards: Int, emojis: [String]) -> MemoryGame<String> {
        return MemoryGame<String>(
            numberOfPairOfCards: numberOfPairOfCards < emojis.count ? numberOfPairOfCards : emojis.count,
            cardContentFactory: { index in emojis[index] }
        )
    }
    
    static func createEmojiMemoryGame(numberOfPairOfCards: Int, emojis: [String]) -> EmojiMemoryGame {
        return EmojiMemoryGame(memoryGame: createMemoryGame(numberOfPairOfCards: numberOfPairOfCards, emojis: emojis))
    }
    
    func choose(card: MemoryGame<String>.Card) {
        model.choose(card: card)
    }
    
    var cards: [MemoryGame<String>.Card] {
        model.cards
    }
    
    var score: Int {
        model.score
    }
}
