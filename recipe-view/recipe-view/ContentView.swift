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
        NavigationView {
            Form {
                Section(header: Text("Recipe URL")) {
                    TextField("Enter URL", text: $url)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.vertical, 8)
                }

                Section {
                    Button(action: {
                        output = url
                    }) {
                        Text("Get Recipe")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                }

                Section(header: Text("Output")) {
                    Text(output)
                        .padding()
                }
            }
            .navigationTitle("Recipe Viewer")
        }
    }
}

#Preview {
    ContentView()
}
