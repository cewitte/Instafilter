//
//  ContentView.swift
//  Instafilter
//
//  Created by Carlos Eduardo Witte on 09/04/25.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        let example = Image(.example)
        
        ShareLink(
            item: example,
            preview: SharePreview("Marcus Aurelius", image: example)
        )
    }
    
}

#Preview {
    ContentView()
}
