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
			// Add a divider after the title
			Divider().padding(.vertical, 8)
			
			// Cook time & difficulty in a horizontal stack
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

			// Replace the existing "Ingredients:" segment with a section-like group:
			Group {
				Text("Ingredients")
					.font(.headline)
					.foregroundColor(.primary)
				ScrollView(showsIndicators: false) {
					VStack(alignment: .leading, spacing: 8) {
						ForEach(recipe.ingredients, id: \.self) { ingredient in
							Text(ingredient)
								.font(.body)
								.foregroundColor(.secondary)
						}
					}
					.padding(.vertical, 4)
				}
			}
			Divider().padding(.vertical, 8)

			// Similarly for Instructions:
			Group {
				Text("Instructions")
					.font(.headline)
					.foregroundColor(.primary)
				ScrollView(showsIndicators: false) {
					VStack(alignment: .leading, spacing: 8) {
						ForEach(recipe.instructions, id: \.self) { instruction in
							Text(instruction)
								.font(.body)
								.foregroundColor(.secondary)
						}
					}
					.padding(.vertical, 4)
				}
			}
		}
        .accessibilityElement(children: .contain)
		.padding()
		.background(.regularMaterial)
		.cornerRadius(12)
		.shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
	}
}

#Preview {
	RecipeCard(recipe: Recipe.mockRecipe)
		.padding()
}
