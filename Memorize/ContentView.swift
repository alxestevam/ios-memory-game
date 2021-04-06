//
//  ContentView.swift
//  Memorize
//
//  Created by Alexandre Estevam on 06/04/21.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    var body: some View {
        HStack() {
            ForEach(0..<4) { _ in
                CardView()
            }
        }
    }
}

struct CardView: View {
    var isFaceUp = true;
    
    var body: some View {
        GeometryReader() { geometry in
            ZStack() {
                if isFaceUp == true {
                    RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: lineWidth).foregroundColor(.orange)
                    Text("🎃").font(Font.system(size: fontSize(for: geometry.size)))
                } else {
                    RoundedRectangle(cornerRadius: cornerRadius).foregroundColor(.orange)
                }
            }
                .aspectRatio(2/3, contentMode: .fit)
        }
    }
    
    // MARK: - Layout constants
    
    let cornerRadius: CGFloat = 10;
    let lineWidth: CGFloat = 3;
    
    func fontSize(for size: CGSize) -> CGFloat {
        min(size.height, size.width) * 0.75
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView()
    }
}
