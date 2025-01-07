//
//  IngredientsView.swift
//  recipe-view
//
//  Created by Lakshya Agarwal on 2025-01-05.
//

import SwiftUI

// MARK: - Models
struct IngredientViewModel: Identifiable {
	let ingredient: Ingredient
	var id: String { ingredient.item }
}

// MARK: - Main View
struct IngredientsSection: View {
	let ingredients: [Ingredient]
	@State private var selectedCategory: Ingredient.Category?
	
	private var groupedIngredients: [Ingredient.Category: [Ingredient]] {
		Dictionary(grouping: ingredients) { $0.category }
	}
	
	var body: some View {
		VStack(alignment: .leading, spacing: 16) {
			CategoryFilterView(
				categories: Array(groupedIngredients.keys).sorted(by: { $0.rawValue < $1.rawValue }),
				selectedCategory: $selectedCategory,
				groupedIngredients: groupedIngredients
			)
			
			IngredientGridView(
				ingredients: selectedCategory.map { groupedIngredients[$0] ?? [] } ?? ingredients
			)
		}
		.padding(.vertical, 16)
	}
}

// MARK: - Category Filter
struct CategoryFilterView: View {
	let categories: [Ingredient.Category]
	@Binding var selectedCategory: Ingredient.Category?
	let groupedIngredients: [Ingredient.Category: [Ingredient]]
	
	var body: some View {
		ScrollView(.horizontal, showsIndicators: false) {
			HStack(spacing: 12) {
				ForEach(categories, id: \.self) { category in
					CategoryPill(
						category: category,
						isSelected: selectedCategory == category,
						count: groupedIngredients[category]?.count ?? 0
					) {
						withAnimation {
							selectedCategory = selectedCategory == category ? nil : category
						}
					}
				}
			}
			.padding(.horizontal, 16)
		}
	}
}

// MARK: - Ingredient Grid
struct IngredientGridView: View {
	let ingredients: [Ingredient]
	
	private let columns = [
		GridItem(.adaptive(minimum: 150, maximum: 150), spacing: 16)
	]
	
	var body: some View {
		VStack(alignment: .leading) {
			Text("\(ingredients.count) items")
				.font(.headline)
				.foregroundColor(AppColors.contentSecondary)
				.padding(.horizontal, 16)
			
			LazyVGrid(columns: columns, spacing: 16) {
				ForEach(ingredients) { ingredient in
					IngredientCard(ingredient: ingredient)
						.frame(height: 150)
				}
			}
			.padding(.horizontal, 16)
		}
	}
}

// MARK: - Supporting Views
struct CategoryPill: View {
	let category: Ingredient.Category
	let isSelected: Bool
	let count: Int
	let action: () -> Void
	
	var body: some View {
		Button(action: action) {
			HStack(spacing: 4) {
				Text(category.emoji)
					.font(.body)
				Text(category.displayName)
					.font(.subheadline.weight(.medium))
				Text("\(count)")
					.font(.caption)
					.opacity(0.7)
			}
			.padding(.horizontal, 12)
			.padding(.vertical, 6)
			.background(isSelected ? AppColors.categoryColor(category) : AppColors.backgroundSecondary)
			.foregroundColor(isSelected ? .white : AppColors.contentPrimary)
			.cornerRadius(16)
		}
	}
}

struct IngredientCard: View {
	let ingredient: Ingredient
	@State private var showSheet = false
	
	private var formattedAmount: String {
		let formatter = NumberFormatter()
		formatter.minimumFractionDigits = 0
		formatter.maximumFractionDigits = 2
		return formatter.string(from: NSNumber(value: ingredient.amount)) ?? "\(ingredient.amount)"
	}
	
	var body: some View {
		VStack(alignment: .leading, spacing: 8) {

			Text(ingredient.category.emoji)
				.font(.system(size: 24))
				.padding(.bottom, 4)
			
			// Optional Badge if needed
			if ingredient.isOptional {
				Text("Optional")
					.font(.caption)
					.padding(.horizontal, 8)
					.padding(.vertical, 4)
					.background(AppColors.backgroundSecondary)
					.foregroundColor(AppColors.contentSecondary)
					.cornerRadius(8)
			}
			
			// Ingredient Name
			Text(ingredient.item)
				.font(.headline)
				.foregroundColor(AppColors.contentPrimary)
				.lineLimit(2)
			
			// Amount and Unit
			HStack(alignment: .firstTextBaseline, spacing: 4) {
				Text(formattedAmount)
					.font(.subheadline)
				Text(ingredient.unit)
					.font(.subheadline)
			}
			.foregroundColor(AppColors.contentSecondary)
			
			// Preparation if available
			if let prep = ingredient.preparation {
				Text(prep)
					.font(.caption)
					.foregroundColor(AppColors.contentTertiary)
					.lineLimit(1)
			}
		}
		.padding()
		.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
		.background(AppColors.backgroundPrimary)
		.cornerRadius(12)
		.shadow(color: AppColors.shadow.opacity(0.1), radius: 2, y: 1)
		.overlay(
			RoundedRectangle(cornerRadius: 12)
				.stroke(AppColors.backgroundSecondary, lineWidth: 1)
		)
		.onTapGesture {
			showSheet = true
		}
		.sheet(isPresented: $showSheet) {
			IngredientDetailSheet(ingredient: ingredient)
		}
	}
}

struct CategoryIcon: View {
	let category: Ingredient.Category
	
	var body: some View {
		Text(category.emoji)
			.font(.system(size: 24))
	}
}

struct IngredientDetailSheet: View {
	let ingredient: Ingredient
	
	private var formattedAmount: String {
		let formatter = NumberFormatter()
		formatter.minimumFractionDigits = 0
		formatter.maximumFractionDigits = 2
		return formatter.string(from: NSNumber(value: ingredient.amount)) ?? "\(ingredient.amount)"
	}

	
	var body: some View {
		NavigationView {
			VStack(alignment: .leading, spacing: 16) {
				// Icon
				Text(ingredient.category.emoji)
					.font(.system(size: 48))
					.padding(.bottom, 8)
				
				// Ingredient Name
				Text(ingredient.item)
					.font(.title2)
					.foregroundColor(AppColors.contentPrimary)
				
				// Quantity and Unit
				HStack(alignment: .firstTextBaseline, spacing: 4) {
					Text(formattedAmount)
						.font(.subheadline)
					Text(ingredient.unit)
						.font(.subheadline)
				}
				
				// Notes (if available)
				if let notes = ingredient.notes, !notes.isEmpty {
						Text("Notes:")
							.font(.headline)
							.foregroundColor(AppColors.contentPrimary)
							.padding(.top, 8)
						
						Text(notes)
							.font(.body)
							.foregroundColor(AppColors.contentTertiary)
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
	ScrollView {
		IngredientsSection(ingredients: mockRecipe.ingredients)
			.padding()
	}
}
