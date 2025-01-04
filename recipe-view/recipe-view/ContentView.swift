//
//  ContentView.swift
//  recipe-view
//
//  Created by Lakshya Agarwal on 2025-01-04.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = RecipeViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 24) {
                    // URL Input Section
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Enter Recipe URL")
                            .font(.headline)
                            .padding(.horizontal)
                        TextField("https://example.com/recipe", text: $viewModel.url)
                            .font(.headline)
                            .foregroundColor(.primary)
                            .accessibilityLabel("Enter recipe URL")
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                            .padding(.horizontal)
                        
                        Button(action: { viewModel.fetchRecipe() }) {
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
                        .disabled(viewModel.url.isEmpty || viewModel.isLoading)
                    }
                    .padding(.top, 20)
                    
                    // Loading Indicator
                    if viewModel.isLoading {
                        ProgressView("Processing recipe...")
                            .progressViewStyle(CircularProgressViewStyle(tint: AppColors.primary))
                            .padding()
                    }
                    
                    // Recipe Display
                    if let currentRecipe = viewModel.recipe {
                        VStack(spacing: 24) {
                            // Original recipe card (optional)
                            RecipeCard(recipe: currentRecipe)

                            // NEW: ingredients grid
                            IngredientsGridView(ingredients: currentRecipe.ingredients)
                                .padding(.horizontal)

                            // NEW: swipe-based instructions
                            SwipeInstructionsView(instructions: currentRecipe.instructions)
                                .padding(.horizontal)
                                .frame(height: 300)
                        }
                        .transition(.scale.combined(with: .opacity))
                    }
                    
                    Spacer(minLength: 20)
                }
            }
            .navigationTitle("Recipe Viewer")
			.background(AppColors.background)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { viewModel.resetForm() }) {
                        Image(systemName: "arrow.clockwise")
                            .foregroundColor(AppColors.primary)
                    }
                }
            }
        }
    }
    
}

#Preview {
    ContentView()
}
