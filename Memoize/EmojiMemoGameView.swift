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
    // The real difference between an @State object vs an @ObservedObject is the lifetimes of the variables involved.
    // @State in a view is gonna cause a variable to come into existence as soon as the view is displayed, but it it taken away as soon as the view is taken away.
    // @ObservedObject causes the lifetime to come from somewhere else, where it is passed in from.
    //
    // Don't call it a viewModel in production
    
    var body: some View {
        VStack {
            // Elements within this are scrollable
            ScrollView {
                cards
                    // .animation(.default, value: viewModel.cards)
                    // This code requires that 'MemoGame<String>.Card' conforms to 'Equatable,' which is a protocol a.k.a. an interface that animation uses in this case
                    .animation(.default, value: viewModel.cards)
                    // They just faded in and out 😭🙏🏾
            }
            Button("Shuffle") {
                viewModel.shuffle()
            }
            .padding()
        }
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 120), spacing: 0)], spacing: 0)  {
            ForEach(viewModel.cards) { card in
                // This affects our animation due to it still showing the card at a certain index even if it changed. So the animation fades in and out instead of moving around here.
                // Another issue... the Generic Struct 'ForEach' wants 'MemoGame<String>.Card' to conform to 'Hashable' for it to do this
                // Dictionaries don't allow duplicate values, so we need another way to uniquely identify the cards rendered.
                // Since we have removed the 'id: \.self,' we now need the 'MemoGame<String>.Card' to conform to 'Identifiable'
                Cardview(card)
                // passing the card instead of the index here
                    .aspectRatio(9/17, contentMode: .fit)
                    .padding(5)
                    .onTapGesture {
                        viewModel.choose(card)
                    }
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
// The preview is getting recreated every time we touch our code. That's why the cards get reset everytime.
// This closure creates a new View everytime so we wouldn't want something like this in our app to cause leaks.
