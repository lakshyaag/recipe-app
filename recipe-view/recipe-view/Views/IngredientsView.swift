//
//  IngredientsView.swift
//  recipe-view
//
//  Created by Lakshya Agarwal on 2025-01-05.
//

import SwiftUI

struct IngredientsSection: View {
	let ingredients: [Ingredient]
	
	// Define the grid layout
	let columns = [
		GridItem(.adaptive(minimum: 150, maximum: 150), spacing: 16)
	]
	
	var body: some View {
		VStack(alignment: .leading, spacing: 16) {
			// Section Header
			HStack {
				Label("Ingredients", systemImage: "basket.fill")
					.font(.system(.title3, design: .rounded, weight: .semibold))
					.foregroundColor(AppColors.text)
					.symbolRenderingMode(.hierarchical)
				
				Spacer()
				
				Text("\(ingredients.count) items")
					.font(.subheadline)
					.foregroundColor(.secondary)
			}
			.padding(.horizontal, 16)
			
			// Grid of Ingredients
			LazyVGrid(columns: columns, spacing: 16) {
				ForEach(ingredients, id: \.item) { ingredient in
					IngredientCard(ingredient: ingredient)
						.frame(height: 150) // Fixed height for consistency
				}
			}
			.padding(.horizontal, 16)
		}
		.padding(.vertical, 16)
	}
}

struct IngredientCard: View {
	let ingredient: Ingredient
	@State private var showSheet = false // State to control the sheet
	
	var body: some View {
		VStack(alignment: .leading, spacing: 8) {
			// Icon (optional, replace with relevant icons)
			Image(systemName: "leaf.fill")
				.font(.system(size: 24))
				.foregroundColor(AppColors.primary)
				.padding(.bottom, 4)
			
			
			// Ingredient Name
			Text(ingredient.item)
				.font(.headline)
				.foregroundColor(.primary)
				.lineLimit(2)
				.truncationMode(.tail)
			
			// Quantity and Unit
			HStack(alignment: .firstTextBaseline, spacing: 4) {
				Text("\(ingredient.amount, specifier: "%.1f")")
					.font(.subheadline)
					.foregroundColor(.secondary)
				
				Text(ingredient.unit)
					.font(.subheadline)
					.foregroundColor(.secondary)
			}
			.lineLimit(1)
			.truncationMode(.tail)
			
			// Notes (if available)
			if let notes = ingredient.notes, !notes.isEmpty {
				Text(notes)
					.font(.footnote)
					.foregroundColor(.gray)
					.lineLimit(2)
					.minimumScaleFactor(0.75)
					.truncationMode(.tail)
			}
		}
		.padding()
		.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
		.background(Color(.systemBackground))
		.cornerRadius(12)
		.shadow(radius: 2)
		.onTapGesture {
			showSheet = true // Show the sheet when the card is tapped
		}
		.sheet(isPresented: $showSheet) {
			IngredientDetailSheet(ingredient: ingredient)
				.presentationDetents([.medium])
				.presentationDragIndicator(.visible)
		}
	}
}

struct IngredientDetailSheet: View {
	let ingredient: Ingredient
	
	var body: some View {
		NavigationView {
			VStack(alignment: .leading, spacing: 16) {
				// Icon (optional)
				Image(systemName: "leaf.fill")
					.font(.system(size: 32))
					.foregroundColor(AppColors.primary)
					.padding(.bottom, 8)
				
				// Ingredient Name
				Text(ingredient.item)
					.font(.title2)
					.foregroundColor(.primary)
				
				// Quantity and Unit
				Text("\(ingredient.amount, specifier: "%.1f") \(ingredient.unit)")
					.font(.title3)
					.foregroundColor(.secondary)
				
				// Notes (if available)
				if let notes = ingredient.notes, !notes.isEmpty {
					Text("Notes:")
						.font(.headline)
						.padding(.top, 8)
					
					Text(notes)
						.font(.body)
						.foregroundColor(.gray)
				}
				
				Spacer()
			}
			.padding()
			.navigationTitle("Ingredient Details")
			.navigationBarTitleDisplayMode(.inline)
			.toolbar {
				ToolbarItem(placement: .primaryAction) {
					Button("Done") {
						// Dismiss the sheet
					}
				}
			}
			.presentationDetents([.medium])
			.presentationDragIndicator(.visible)
		}
	}
}

#Preview {
	ScrollView{
		IngredientsSection(ingredients: mockRecipe.ingredients).padding()
	}
}
