//
//  MemoizeApp.swift
//  Memoize
//
//  Created by Mwanda Chipongo on 02/08/2024.
//

import SwiftUI

@main
struct MemoizeApp: App {
    @StateObject var game = EmojiMemoizeGame()
    
    var body: some Scene {
        WindowGroup {
            EmojiMemoGameView(viewModel: game)
        }
    }
}
