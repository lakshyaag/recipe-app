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
			.background(AppColors.background)
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
        guard let requestUrl = URL(string: "http://localhost:8000/process") else { return }
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: Any] = ["url": url]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
        
        isLoading = true
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                isLoading = false
                if let data = data {
                    do {
                        let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                        if let recipeData = jsonResponse?["recipe"] as? [String: Any] {
                            let recipeJSONData = try JSONSerialization.data(withJSONObject: recipeData, options: [])
                            let decodedRecipe = try JSONDecoder().decode(Recipe.self, from: recipeJSONData)
                            self.recipe = decodedRecipe
                        } else {
                            print("Recipe key not found in response")
                        }
                    } catch {
                        print("Error decoding recipe: \(error)")
                    }
                } else if let error = error {
                    print("Error fetching recipe: \(error)")
                }
            }
        }.resume()
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
