//
//  EmojiMemoizeGame.swift
//  Memoize
//
//  Created by Mwanda Chipongo on 08/09/2024.
//


import SwiftUI


class EmojiMemoizeGame: ObservableObject {
    private static let emojis = ["💀","👹","😱","😎","🗣️","☹️","🥭","😏","👽","🤡","😭","🤣","🍭"]
    
    
    // We don't wqant any one creating a memory game so this is private
    private static func createMemoryGame() -> MemoGame<String> {
        return MemoGame(numberOfPairsOfCards: 6) { pairIndex in
            // Ensure that the array index isn't out of bounds
            if emojis.indices.contains(pairIndex) {
                return emojis[pairIndex]
            } else {
                return "⁉️"
            }
        }
    }
    
    // private access so only the viewModel can do it's thing
    // don't call the model 'model' in production
    @Published private var model = createMemoryGame()
    
    
    var cards: Array<MemoGame<String>.Card> {
        return model.cards
    }
    
    // MARK: - Intents
    
    // The internal name is card, the external name is provided by the user intent
    func choose(_ card: MemoGame<String>.Card) {
        model.choose(card)
    }
    
    func shuffle() {
        model.shuffle()
    }
}
