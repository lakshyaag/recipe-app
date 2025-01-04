import SwiftUI

struct RecipeCard: View {
	let recipe: Recipe

	var body: some View {
		VStack(alignment: .leading, spacing: 16) {
			HStack(spacing: 8) {
				Image(systemName: "frying.pan")
					.foregroundColor(.primary)
				Text(recipe.title)
					.font(.title2)
					.fontWeight(.bold)
					.foregroundColor(.primary)
			}
			
			Divider().padding(.vertical, 8)
			
			
			HStack(spacing: 16) {
				if let cookTime = recipe.cookTime, !cookTime.isEmpty {
					Label(cookTime, systemImage: "clock")
						.font(.caption)
						.foregroundColor(.secondary)
				}
				if let difficulty = recipe.difficulty, !difficulty.isEmpty {
					Label(difficulty, systemImage: "exclamationmark.triangle")
						.font(.caption)
						.foregroundColor(.secondary)
				}
			}
			.padding(.bottom, 8)

			
			Group {
				Text("Ingredients")
					.font(.headline)
					.foregroundColor(.primary)
				IngredientsGridView(ingredients: recipe.ingredients)
			}
			Divider().padding(.vertical, 8)

			
			Group {
				Text("Instructions")
					.font(.headline)
					.foregroundColor(.primary)
				SwipeInstructionsView(instructions: recipe.instructions)
			}
		}
        .accessibilityElement(children: .contain)
		.padding()
		.background(.ultraThickMaterial)
		.cornerRadius(12)
		.shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
	}
}

#Preview {
	RecipeCard(recipe: Recipe.mockRecipe)
		.padding()
}
