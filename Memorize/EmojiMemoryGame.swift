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
    
    func choose(card: MemoryGame<String>.Card) {
        model.choose(card: card)
    }
    
    var cards: [MemoryGame<String>.Card] {
        model.cards
    }
}
