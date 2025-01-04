//
//  ContentView.swift
//  recipe-view
//
//  Created by Lakshya Agarwal on 2025-01-04.
//

import SwiftUI

struct ContentView: View {
    @State private var url: String = ""
    @State private var output: String = ""

    var body: some View {
        VStack {
            TextField("Enter URL", text: $url)
                .padding()
                .border(.secondary)

            Button("Get Recipe") {
                output = url
            }
            .padding()

            Text(output)
                .padding()
        }
    }
}

#Preview {
    ContentView()
}
