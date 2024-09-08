//
//  ContentView.swift
//  Memoize
//
//  Created by Mwanda Chipongo on 02/08/2024.
//

import SwiftUI

struct ContentView: View {
    // Its clear that the type of 'emoji' is an array of strings
    // It can be written as: let emojis: [String] = ...
    // It's identical
    // Swift programmers use the square bracket notation
    let emojis: Array<String> = ["💀","👹","😱","😎","🗣️","☹️","🥭","😏","👽","🤡","😭"]
    
    var body: some View {
        // Elements within this are scrollable
        ScrollView {
            cards
        }
        .padding()
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 120))])  {
                // To reach into an array and render an object for each element in an array
                // 'emojis.indices' gives a range of all the elements in it to avoid hard coding it
                // We have changed it to have a range from the first element to the end of the card count
                //element
            ForEach(emojis.indices, id: \.self) { index in
                Cardview(content: emojis[index])
                    .aspectRatio(10/16, contentMode: .fit)
            }
            .foregroundColor(.orange)
        }
    }
}


struct Cardview: View {
    // Setting @State before the var causes it to create a pointer to isFaceUp
    // Since a view is immutable by default, this allows values in a view to be changed
    // because the pointer isn't changing, the value it is pointing at is.
    @State var isFaceUp = false
    // Default value is set to prevent providing a value
    // every single time.
    // If a let is used, the user can only set it once
    // Otherwise it can be swapped
    // Always start off with it being immutable
    let content: String
    
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
                Text(content).font(.largeTitle)
            }
            .opacity(isFaceUp ? 1 : 0)
            base.fill().opacity(isFaceUp ? 0 : 1)
            
        }
        .onTapGesture {
            // isFaceUp = !isFaceUp
            // this throws and error cause views are immutable
            // The idiomatic Swift way to change this would be to use .toggle()
            isFaceUp.toggle()
        }
    }
}

#Preview {
    ContentView()
}
