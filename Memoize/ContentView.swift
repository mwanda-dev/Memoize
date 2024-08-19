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
    let emojis: Array<String> = ["💀","👹","😱","😎","🗣️","☹️","🥭","😏","👽","🤡"]
    @State var cardCount: Int = 4
    
    var body: some View {
        VStack {
            VStack {
                    // To reach into an array and render an object for each element in an array
                    // 'emojis.indices' gives a range of all the elements in it to avoid hard coding it
                    // We have changed it to have a range from the first element to the end of the card count
                    //element
                ForEach(0..<cardCount, id: \.self) { index in
                    Cardview(content: emojis[index])
                }
            }
            .foregroundColor(.orange)
            
            HStack {
                Button(action: {
                    if cardCount > 1 {
                        cardCount -= 1
                    }
                }, label: {
                    Image(systemName: "rectangle.stack.badge.minus")
                })
                
                Spacer()
                
                Button(action: {
                    if cardCount < emojis.count {
                        cardCount += 1
                    }
                }, label: {
                    Image(systemName: "rectangle.stack.badge.plus")
                })
                
            }
            .font(.largeTitle)
            .imageScale(.large)
        }
        .padding()
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
            if isFaceUp {
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text(content).font(.largeTitle)
            } else {
                base.fill()
            }
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
