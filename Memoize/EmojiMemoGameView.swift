//
//  ContentView.swift
//  Memoize
//
//  Created by Mwanda Chipongo on 02/08/2024.
//

import SwiftUI

struct EmojiMemoGameView: View {
    // Its clear that the type of 'emoji' is an array of strings
    // It can be written as: let emojis: [String] = ...
    // It's identical
    // Swift programmers use the square bracket notation
    @ObservedObject var viewModel: EmojiMemoizeGame
    // Don't call it a viewModel in production
    
    var body: some View {
        VStack {
            // Elements within this are scrollable
            ScrollView {
                cards
            }
            Button("Shuffle") {
                viewModel.shuffle()
            }
            .padding()
        }
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 120), spacing: 0)], spacing: 0)  {
                // To reach into an array and render an object for each element in an array
                // 'emojis.indices' gives a range of all the elements in it to avoid hard coding it
                // We have changed it to have a range from the first element to the end of the card count
                //element
            ForEach(viewModel.cards.indices, id: \.self) { index in
                Cardview(viewModel.cards[index])
                    .aspectRatio(10/16, contentMode: .fit)
                    .padding(5)
            }
            .foregroundColor(.orange)
        }
    }
}


struct Cardview: View {
    let card: MemoGame<String>.Card

    init(_ card: MemoGame<String>.Card) {
        self.card = card
    }
    
    // Setting @State before the var causes it to create a pointer to isFaceUp
    // Since a view is immutable by default, this allows values in a view to be changed
    // because the pointer isn't changing, the value it is pointing at is.
    // @State var isFaceUp = false
    // Default value is set to prevent providing a value
    // every single time.
    // If a let is used, the user can only set it once
    // Otherwise it can be swapped
    // Always start off with it being immutable
    
    var body: some View {
        ZStack{
            // Type inference used here, don't have to write Rounded Rectangle twice
            let base = RoundedRectangle(cornerRadius: 12)
            // The issue with the if, is the background wasn't rendered because of the branches in the conditional
            // In this group, the background fill is there from the start, here we just make the
            // emojis transparent
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text(card.content)
                    .font(.system(size: 200))
                    .minimumScaleFactor(0.01)
                    .aspectRatio(1, contentMode: .fit)
            }
                .opacity(card.isFaceUp ? 1 : 0)
            base.fill()
                .opacity(card.isFaceUp ? 0 : 1)
        }
    }
}

#Preview {
    EmojiMemoGameView(viewModel: EmojiMemoizeGame())
}
