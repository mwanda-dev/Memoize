//
//  ContentView.swift
//  Memoize
//
//  Created by Mwanda Chipongo on 02/08/2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Cardview(isFaceUp: true)
            Cardview()
            Cardview(isFaceUp: true)
            Cardview()
        }
        .foregroundColor(.orange)
        .padding()
    }
}


struct Cardview: View {
    // Setting @State before the var causes it to create a pointer to isFaceUp
    // Since a view is immutable by default, this allows values in a view to be changed
    // because the pointer isn't changing, the value it is pointing at is.
    @State var isFaceUp: Bool = false
    // Default value is set to prevent providing a value
    // every single time.
    // If a let is used, the user can only set it once
    // Otherwise it can be swapped
    // Always start off with it being immutable
    
    var body: some View {
        ZStack{
            // Type inference used here, don't have to write Rounded Rectangle twice
            let base = RoundedRectangle(cornerRadius: 12)
            if isFaceUp {
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text("💀").font(.largeTitle)
            } else {
                base.fill()
            }
        }
        .onTapGesture {
            //isFaceUp = !isFaceUp
            // this throws and error cause views are immutable
            // The idiomatic Swift way to change this would be to use .toggle()
            isFaceUp.toggle()
        }
    }
}














#Preview {
    ContentView()
}
