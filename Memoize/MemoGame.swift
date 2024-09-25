//
//  MemoizeGame.swift
//  Memoize
//
//  Created by Mwanda Chipongo on 08/09/2024.
//

import Foundation

struct MemoGame<CardContent> {
    // Allows looking at the variable from outside, but not modifying it
    private(set) var cards: Array<Card>
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = []
        // can also say 'cards = Array<Card>()' or 'cards = [Card]()'
        
        // add number of pairs of cards * 2 cards to the array
        
        for pairIndex in 0..<max(2, numberOfPairsOfCards) {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content))
            cards.append(Card(content: content))
        }
    }
    
    func choose(_ card: Card) {
        
    }
    
    mutating func shuffle() {
        cards.shuffle()
        print(cards)
    }
    
    struct Card {
        var isFaceUp = true
        var isMatched = false
        let content: CardContent
    }
}

