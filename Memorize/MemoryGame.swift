//
//  MemoryGame.swift
//  Memorize
//
//  Created by Alexandre Estevam on 06/04/21.
//

import Foundation

struct MemoryGame<Content> where Content: Equatable {
    var cards: [Card] = []
    
    var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            cards.indices.filter({ cards[$0].isFaceUp }).only
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = index == newValue
            }
        }
    }
    
    mutating func choose(card: Card) {
        if let chosenCardIndex = cards.firstIndex(of: card), !cards[chosenCardIndex].isFaceUp, !cards[chosenCardIndex].isMatched {
            if let potentialMatchIndex = indexOfOneAndOnlyFaceUpCard {
                if cards[chosenCardIndex].content == cards[potentialMatchIndex].content {
                    cards[chosenCardIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                }
                cards[chosenCardIndex].isFaceUp = true
            } else {
                indexOfOneAndOnlyFaceUpCard = chosenCardIndex
            }
        }
    }
    
    init(numberOfPairOfCards: Int, cardContentFactory: (_ index: Int) -> Content) {
        for index in 0..<numberOfPairOfCards {
            cards.append(Card(id: index * 2, content: cardContentFactory(index)))
            cards.append(Card(id: index * 2 + 1, content: cardContentFactory(index)))
        }
        cards.shuffle()
    }
    
    struct Card: Identifiable {
        var id: Int
        var content: Content
        var isFaceUp: Bool = false
        var isMatched: Bool = false
    }
}

