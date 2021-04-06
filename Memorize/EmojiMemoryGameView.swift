//
//  ContentView.swift
//  Memorize
//
//  Created by Alexandre Estevam on 06/04/21.
//

import SwiftUI

func createEmojiMemoryGame() -> EmojiMemoryGame {
    let emojis: [String] = ["🎃", "👻", "🧹", "🕸", "🧙‍♀️"]
    
    return EmojiMemoryGame(memoryGame: MemoryGame<String>(numberOfPairOfCards: emojis.count, cardContentFactory: { index in
        emojis[index]
    }))
}

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        Grid(viewModel.cards) { card in
            CardView(card: card)
                .onTapGesture { viewModel.choose(card: card) }
                .padding()
        }
    }
}

struct CardView: View {
    var card: MemoryGame<String>.Card
    
    var body: some View {
        GeometryReader() { geometry in
            ZStack() {
                if card.isFaceUp {
                    RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: lineWidth).foregroundColor(.orange)
                    RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
                    Text(card.content).font(Font.system(size: fontSize(for: geometry.size)))
                } else {
                    if !card.isMatched {
                        RoundedRectangle(cornerRadius: cornerRadius).foregroundColor(.orange)
                    }
                    
                }
            }
        }
            .aspectRatio(2/3, contentMode: .fit)
    }
    
    // MARK: - Layout constants
    
    let cornerRadius: CGFloat = 10
    let lineWidth: CGFloat = 3
    
    func fontSize(for size: CGSize) -> CGFloat {
        min(size.height, size.width) * 0.75
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(viewModel: createEmojiMemoryGame())
    }
}
