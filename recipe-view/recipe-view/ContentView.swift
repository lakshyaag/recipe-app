//
//  ContentView.swift
//  recipe-view
//
//  Created by Lakshya Agarwal on 2025-01-04.
//

import SwiftUI
import UIKit

struct ContentView: View {
	@StateObject private var viewModel = RecipeViewModel()
	
	var body: some View {
		NavigationStack {
			VStack {
				// URL Input and fetch button
				RecipeURLInputView(viewModel: viewModel)
				
				if let recipe = viewModel.recipe {
					NavigationLink {
						RecipeDetailView(recipe: recipe)
					} label: {
						RecipeCard(recipe: recipe)
					}
				}
			}
			.padding()
			.navigationTitle("Recipe Parser")
		}
	}
}

#Preview {
	ContentView()
}
