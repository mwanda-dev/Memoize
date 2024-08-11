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
            Cardview()
            Cardview()
        }
        .foregroundColor(.orange)
        .padding()
    }
}


struct Cardview: View {
    var isFaceUp: Bool = false
    var body: some View {
        ZStack(content: {
            if isFaceUp {
                RoundedRectangle(cornerRadius: 12)
                    .foregroundColor(.white)
                RoundedRectangle(cornerRadius: 12)
                    .strokeBorder(lineWidth: 2)
                Text("💀").font(.largeTitle)
            } else {
                RoundedRectangle(cornerRadius: 12)
                RoundedRectangle(cornerRadius: 12)
                    .strokeBorder(lineWidth: 2)
            }
        })
    }
}














#Preview {
    ContentView()
}
