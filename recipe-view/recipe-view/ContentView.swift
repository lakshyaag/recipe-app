//
//  ContentView.swift
//  recipe-view
//
//  Created by Lakshya Agarwal on 2025-01-04.
//

import SwiftUI

struct ContentView: View {
    @State private var url: String = ""
    @State private var recipe: Recipe? = nil
    @State private var isLoading: Bool = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 24) {
                    // URL Input Section
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Enter Recipe URL")
                            .font(.headline)
                            .padding(.horizontal)
                        
                        TextField("https://example.com/recipe", text: $url)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                            .padding(.horizontal)
                        
                        Button(action: fetchRecipe) {
                            HStack {
                                Image(systemName: "magnifyingglass")
                                Text("Get Recipe")
                            }
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(
                                LinearGradient(
                                    gradient: Gradient(colors: [AppColors.primary, AppColors.secondary]),
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .foregroundColor(.white)
                            .cornerRadius(12)
                            .shadow(radius: 5)
                        }
                        .padding(.horizontal)
                        .disabled(url.isEmpty || isLoading)
                    }
                    .padding(.top, 20)
                    
                    // Loading Indicator
                    if isLoading {
                        ProgressView("Processing recipe...")
                            .progressViewStyle(CircularProgressViewStyle(tint: AppColors.primary))
                            .padding()
                    }
                    
                    // Recipe Display
                    if let recipe = recipe {
                        RecipeCard(recipe: recipe)
                            .padding(.horizontal)
                            .transition(.scale.combined(with: .opacity))
                    }
                    
                    Spacer(minLength: 20)
                }
            }
            .navigationTitle("Recipe Viewer")
            .background(AppColors.background.edgesIgnoringSafeArea(.all))
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: resetForm) {
                        Image(systemName: "arrow.clockwise")
                            .foregroundColor(AppColors.primary)
                    }
                }
            }
        }
    }
    
    private func fetchRecipe() {
        withAnimation {
            isLoading = true
            // Simulate network call
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                recipe = Recipe(
                    name: "Sample Recipe",
                    description: "This is a sample recipe description that would come from the backend. It includes details about the dish and its preparation.",
                    url: url
                )
                withAnimation {
                    isLoading = false
                }
            }
        }
    }
    
    private func resetForm() {
        withAnimation {
            url = ""
            recipe = nil
            isLoading = false
        }
    }
}

#Preview {
    ContentView()
}
