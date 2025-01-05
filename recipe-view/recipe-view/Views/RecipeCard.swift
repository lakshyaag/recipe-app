import SwiftUI

struct RecipeCard: View {
	let recipe: Recipe

	var body: some View {
		VStack(alignment: .leading, spacing: 24) {
			// Header
			VStack(alignment: .leading, spacing: 16) {
				HStack(spacing: 12) {
					Text(recipe.title)
						.font(.system(.title, design: .rounded, weight: .bold))
						.foregroundColor(AppColors.text)
				}
				
				// Recipe metadata
				HStack(spacing: 20) {
					if let cookTime = recipe.cookTime {
							Label {
								Text(cookTime)
									.font(.subheadline)
							} icon: {
								Image(systemName: "timer")
									.foregroundStyle(AppColors.accent)
									.symbolRenderingMode(.hierarchical)
							}
					}
					
					if let difficulty = recipe.difficulty {
							Label {
								Text(difficulty.capitalized)
									.font(.subheadline)
							} icon: {
								Image(systemName: "gauge.with.dots.needle.50percent")
									.foregroundStyle(AppColors.accent)
									.symbolRenderingMode(.hierarchical)
							}
					}
				}
				.foregroundColor(AppColors.secondaryText)
			}
			
			Divider()
				.background(AppColors.divider)
			
			// Ingredients Section
			VStack(alignment: .leading, spacing: 16) {
				Label("Ingredients", systemImage: "basket.fill")
					.font(.system(.title2, design: .rounded, weight: .semibold))
					.foregroundStyle(AppColors.text)
					.symbolRenderingMode(.hierarchical)
				
				IngredientsGridView(ingredients: recipe.ingredients)
			}
			
			Divider()
				.background(AppColors.divider)
			
			// Instructions Section
			VStack(alignment: .leading, spacing: 16) {
				Label("Instructions", systemImage: "list.bullet.clipboard.fill")
					.font(.system(.title2, design: .rounded, weight: .semibold))
					.foregroundStyle(AppColors.text)
					.symbolRenderingMode(.hierarchical)
				
				SwipeInstructionsView(instructions: recipe.instructions)
			}
		}
		.padding(20)
		.background(AppColors.cardBackground)
		.cornerRadius(16)
	}
}

#Preview {
	RecipeCard(recipe: Recipe.mockRecipe)
		.padding()
		.background(AppColors.background)
}
