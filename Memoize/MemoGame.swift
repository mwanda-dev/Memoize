//
//  MemoizeGame.swift
//  Memoize
//
//  Created by Mwanda Chipongo on 08/09/2024.
//

import Foundation

struct MemoGame<CardContent> {
    var cards: Array<Card>
    
    func choose(card: Card) {
        
    }
    
    struct Card {
        var isFaceUp: Bool
        var isMatched: Bool
        var content: CardContent
        
    }
}

