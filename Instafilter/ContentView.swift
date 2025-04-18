//
//  ContentView.swift
//  Instafilter
//
//  Created by Carlos Eduardo Witte on 09/04/25.
//

import SwiftUI

struct ContentView: View {
    @State private var showingConfirmation = false
    @State private var backgroundColor = Color.white
    @State private var text: String = ""
    
    var body: some View {
        Button("Hello World!") {
            showingConfirmation = true
        }
        .frame(width: 300, height: 300)
        .background(backgroundColor)
        .confirmationDialog("Change Background", isPresented: $showingConfirmation) {
            Button("Red") { backgroundColor = .red }
            Button("Green") { backgroundColor = .green }
            Button("Blue") { backgroundColor = .blue }
            Button("Cancel", role: .cancel) {}
            
        } message: {
            Text("Select a new color")
        }
    }
}

#Preview {
    ContentView()
}
