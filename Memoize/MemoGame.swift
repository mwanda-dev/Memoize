//
//  MemoizeGame.swift
//  Memoize
//
//  Created by Mwanda Chipongo on 08/09/2024.
//

import Foundation

struct MemoGame<CardContent> where CardContent: Equatable {
    // Now we know Card Content conforms to equatable
    // Allows looking at the variable from outside, but not modifying it
    private(set) var cards: Array<Card>
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = []
        // can also say 'cards = Array<Card>()' or 'cards = [Card]()'
        
        // add number of pairs of cards * 2 cards to the array
        
for pairIndex in 0..<max(2, numberOfPairsOfCards) {
            let content = cardContentFactory(pairIndex)
    cards.append(Card(content: content, id: "\(pairIndex + 1)a"))
    cards.append(Card(content: content, id: "\(pairIndex + 1)b"))
    // Using string interpolation, we can use the expression in the loop to set a unique identifier as the card is being created, then using a or b to denote the first or second card of the same type
        }
    }
    
    func choose(_ card: Card) {
        
    }
    
    mutating func shuffle() {
        cards.shuffle()
        print(cards)
    }
    
    // Just saying struct Card: Equatable doesn't mean that it will just become Equatable
    struct Card: Equatable, Identifiable, CustomDebugStringConvertible {
        
        // You need a var called id to conform, the quick fix puts a placeholder type called ObjectIdentifier
        // It's actually a kinda care: anything that is 'Hashable' will do
        
        // This function called '==' compares the values in every field of the struct
            // static func == (lhs: Card, rhs: MemoGame<CardContent>.Card) -> Bool {
                // return lhs.isFaceUp == rhs.isFaceUp &&
                //lhs.isMatched == rhs.isMatched &&
                // lhs.content == rhs.content
                    // Now we need content to conform to equatable 🤣
                    // We made it conform
            // }
        // One nice thing here is that, since we're just comparing all the fields of the struct, we don't need to write out this function.
        // It gets created automatically
        // All the vars are equatable, so it can derive an equatable for the whole thing.
        
        // This should be equatable to use the animation
        var isFaceUp = true
        var isMatched = false
        let content: CardContent
        var id: String
        // id is down here due to convention
        var debugDescription: String {
            "\(id): \(content) \(isFaceUp ? "up" : "down")\(isMatched ? " matched" : "")"
        }
        // Last Time stamp on Youtube video: 23:50
    }
}

