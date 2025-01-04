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
    @State private var isShowingOutput: Bool = false

    var body: some View {
        NavigationView {
            VStack {
                VStack(alignment: .leading, spacing: 16) {
                    Text("Enter Recipe URL")
                        .font(.headline)
                        .padding(.horizontal)

                    TextField("https://example.com", text: $url)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)
                        .padding(.bottom, 20)

                    Button(action: {
                        withAnimation {
                            output = url
                            isShowingOutput = true
                        }
                    }) {
                        Text("Fetch Recipe")
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .leading, endPoint: .trailing))
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .shadow(radius: 5)
                    }
                    .padding(.horizontal)
                }
                .padding(.top, 40)

                if isShowingOutput {
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Output")
                            .font(.headline)
                            .padding(.horizontal)

                        Text(output)
                            .padding()
                            .background(Color(UIColor.secondarySystemBackground))
                            .cornerRadius(10)
                            .padding(.horizontal)
                    }
                    .transition(.slide)
                }

                Spacer()
            }
            .navigationTitle("Recipe Viewer")
            .background(Color(UIColor.systemGroupedBackground).edgesIgnoringSafeArea(.all))
        }
    }
}

#Preview {
    ContentView()
}
