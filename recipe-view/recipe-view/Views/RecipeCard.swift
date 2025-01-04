import SwiftUI

struct RecipeCard: View {
	let recipe: Recipe

	var body: some View {
		VStack(alignment: .leading, spacing: 16) {
			HStack {
				Image(systemName: "frying.pan")
					.foregroundColor(.primary)
				Text(recipe.title)
					.font(.title2)
					.fontWeight(.bold)
					.foregroundColor(.primary)
			}
            
            if let cookTime = recipe.cookTime, !cookTime.isEmpty {
                Text("Cook Time: \(cookTime)")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }

            if let difficulty = recipe.difficulty, !difficulty.isEmpty {
                Text("Difficulty: \(difficulty)")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }

			Text("Ingredients:")
				.font(.headline)
				.foregroundColor(.secondary)

			// Use a ScrollView for better layout control
			ScrollView {
				VStack(alignment: .leading, spacing: 8) {
					ForEach(recipe.ingredients, id: \.self) { ingredient in
						Text(ingredient)
							.font(.body)
							.foregroundColor(.secondary)
					}
				}
			}

			Text("Instructions:")
				.font(.headline)
				.foregroundColor(.secondary)

			ScrollView {
				VStack(alignment: .leading, spacing: 8) {
					ForEach(recipe.instructions, id: \.self) { instruction in
						Text(instruction)
							.font(.body)
							.foregroundColor(.secondary)
					}
				}
			}
		}
        .accessibilityElement(children: .contain)
		.padding()
		.background(AppColors.cardBackground)
		.cornerRadius(12)
		.shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
	}
}

#Preview {
	RecipeCard(recipe: Recipe(title: "Sample Recipe", ingredients: ["1 cup flour", "2 eggs"], instructions: ["Mix ingredients", "Bake for 20 minutes"]))
		.padding()
}
