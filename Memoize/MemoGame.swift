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
    
    // Now we have much more readable code 🥰
    var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get { cards.indices.filter { index in cards[index].isFaceUp }.only }
        set { cards.indices.forEach { cards[$0].isFaceUp = (newValue == $0) } }
    }
    
    mutating func choose(_ card: Card) {
       print("Chosen card: \(card)")
       // The card var is a value type, not a reference, so directly flipping the card doesn't work
       // We don't use the index method we wrote by using built in array functions
           // Trailing closure syntax might be confusable with the body of the statement, so passing it as a parenthesized argument is better
       if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }) {
                   // Always get rid of any warnings
           // Here we use an optional to check the index of the card incase it doesn't have an index
           
           // You can flip cards over only face up:
           if !cards[chosenIndex].isFaceUp && !cards[chosenIndex].isMatched {
               if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                   if cards[potentialMatchIndex].content == cards[chosenIndex].content {
                       cards[potentialMatchIndex].isMatched = true
                       cards[chosenIndex].isMatched = true
                   }
               } else {
                   indexOfTheOneAndOnlyFaceUpCard = chosenIndex
               }
               cards[chosenIndex].isFaceUp = true
            }           // This is our main game logic, kinda obvious if you read it
        } // We don't do anything if there's no index here
        // The only issue with this code is that the matched cards don't disappear from the view...
    }
    
    mutating func shuffle() {
        cards.shuffle()
        print(cards)
    }
    
            // Here we're not sure whether a given card will have an index
            // private func index(of card: Card) -> Optional<Int> {
                // for index in cards.indices {
                    // if cards[index].id == card.id {
                    //     return index
                  //   }
                // }
              //   return nil
            // }
    
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
        var isFaceUp = false
        var isMatched = false
        let content: CardContent
        var id: String
        // id is down here due to convention
        var debugDescription: String {
            "\(id): \(content) \(isFaceUp ? "up" : "down")\(isMatched ? " matched" : "")"
        }
    }
}

// This is called an Extension:
// We're extending the functionality of the Array type

extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
