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
					if let cookTimeAmount = recipe.cookTimeAmount,
					   let cookTimeUnit = recipe.cookTimeUnit {
							Label {
								Text("\(cookTimeAmount, specifier: "%.0f") \(cookTimeUnit)")
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
		}
		.padding(20)
		.background(AppColors.cardBackground)
		.cornerRadius(16)
	}
}

#Preview {
	RecipeCard(recipe: mockRecipe)
		.padding()
		.background(AppColors.background)
}
