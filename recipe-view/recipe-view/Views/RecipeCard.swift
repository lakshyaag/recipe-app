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
								Text("\(cookTime.amount, specifier: "%.0f") \(cookTime.unit)")
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
				
                ForEach(recipe.ingredients, id: \.item) { ingredient in
                    Text("\(ingredient.amount, specifier: "%.1f") \(ingredient.unit) \(ingredient.item)")
                        .font(.body)
                    if let notes = ingredient.notes, !notes.isEmpty {
                        Text(notes)
                            .font(.footnote)
                            .foregroundColor(.gray)
                    }
                }
			}
			
			Divider()
				.background(AppColors.divider)
			
			// Instructions Section
			VStack(alignment: .leading, spacing: 16) {
				Label("Instructions", systemImage: "list.bullet.clipboard.fill")
					.font(.system(.title2, design: .rounded, weight: .semibold))
					.foregroundStyle(AppColors.text)
					.symbolRenderingMode(.hierarchical)
				
                ForEach(recipe.instructions, id: \.step) { instruction in
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Step \(instruction.step)")
                            .font(.headline)
                        Text(instruction.description)
                        if let timeInfo = instruction.time {
                            Text("Time: \(timeInfo.amount, specifier: "%.1f") \(timeInfo.unit)")
                                .font(.footnote)
                                .foregroundColor(.gray)
                        }
                    }
                }
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
