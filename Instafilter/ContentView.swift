//
//  ContentView.swift
//  Instafilter
//
//  Created by Carlos Eduardo Witte on 09/04/25.
//

import SwiftUI
import StoreKit

struct ContentView: View {
    @Environment(\.requestReview) var requestReview
    
    
    var body: some View {
        Button("Leave a review") {
            requestReview()
        }
    }
    
}

#Preview {
    ContentView()
}
