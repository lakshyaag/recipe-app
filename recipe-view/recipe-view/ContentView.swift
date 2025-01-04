//
//  ContentView.swift
//  recipe-view
//
//  Created by Lakshya Agarwal on 2025-01-04.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HStack {
			VStack() {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundStyle(Color.blue)
                Text("Hello, world!")
            }
			.padding()
			
            
            Label("Recipes", systemImage: "list.bullet")
        }
    }
}

#Preview {
    ContentView()
}
