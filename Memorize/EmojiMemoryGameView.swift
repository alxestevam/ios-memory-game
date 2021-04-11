//
//  ContentView.swift
//  Memorize
//
//  Created by Alexandre Estevam on 06/04/21.
//

import SwiftUI



struct EmojiMemoryGameView: View {
    @ObservedObject private(set) var game: EmojiMemoryGame
    @State var theme: Theme

    static let themes = [
        Theme(name: "Halloween", emojis: ["🎃", "👻", "🧹", "🕸", "🧙‍♀️"], foregroundColor: .orange, numberOfPairOfCards: 5),
        Theme(name: "Weather", emojis: ["☀️", "🌨", "❄️", "🌦", "🌤"], foregroundColor: .blue, numberOfPairOfCards: 5),
        Theme(name: "Fruit", emojis: ["🍏", "🍎", "🍐", "🍊", "🍋"], foregroundColor: .green, numberOfPairOfCards: 5),
        Theme(name: "Meat", emojis: ["🍗", "🍖", "🥩", "🥓"], foregroundColor: .yellow, numberOfPairOfCards: 4),
        Theme(name: "Ball", emojis: ["⚽️", "🏀", "⚾️", "🏈", "🏐"], foregroundColor: .gray, numberOfPairOfCards: 5),
        Theme(name: "Car", emojis: ["🚗", "🚕", "🚙", "🚌", "🚎"], foregroundColor: .purple)
    ]
    
    var body: some View {
        VStack() {
            Text(theme.name)
            Text("Score: \(game.score)")
            Grid(game.cards) { card in
                CardView(card: card)
                    .onTapGesture { game.choose(card: card) }
                    .padding()
                    .aspectRatio(2/3, contentMode: .fit)
                    .foregroundColor(theme.foregroundColor)
            }
            Button("New Game", action: {
                let theme = EmojiMemoryGameView.themes[Int.random(in: 1..<EmojiMemoryGameView.themes.count)]
                self.startNewGame(theme: theme)
            })
        }
    }
    
    static func createEmojiMemoryGameView(theme: Theme) -> EmojiMemoryGameView {
        EmojiMemoryGameView(game: EmojiMemoryGame.createEmojiMemoryGame(numberOfPairOfCards: theme.numberOfPairOfCards, emojis: theme.emojis), theme: theme)
    }
    
    private func startNewGame(theme: Theme) {
        game.startNewGame(numberOfPairOfCards: theme.numberOfPairOfCards, emojis: theme.emojis)
        self.theme = theme
    }
    
    struct Theme {
        var name: String
        var emojis: [String]
        var numberOfPairOfCards: Int
        var foregroundColor: Color
        
        init (name: String, emojis: [String], foregroundColor: Color) {
            self.init(name: name, emojis: emojis, foregroundColor: foregroundColor, numberOfPairOfCards: Int.random(in: 0..<emojis.count))
        }
        
        init (name: String, emojis: [String], foregroundColor: Color, numberOfPairOfCards: Int) {
            self.name = name
            self.emojis = emojis
            self.foregroundColor = foregroundColor
            self.numberOfPairOfCards = numberOfPairOfCards
        }
    }
}

struct CardView: View {
    var card: MemoryGame<String>.Card
    
    var body: some View {
        GeometryReader() { geometry in
            ZStack() {
                if card.isFaceUp {
                    RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: lineWidth)
                    RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
                    Text(card.content).font(Font.system(size: fontSize(for: geometry.size)))
                } else {
                    if !card.isMatched {
                        RoundedRectangle(cornerRadius: cornerRadius)
                    }
                    
                }
            }
        }
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
        
        let view = EmojiMemoryGameView.createEmojiMemoryGameView(theme: EmojiMemoryGameView.themes[0])
        
        view.game.choose(card: view.game.cards[0])
        
        return view
    }
}
