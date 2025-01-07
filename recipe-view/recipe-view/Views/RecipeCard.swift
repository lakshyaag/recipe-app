import SwiftUI

struct RecipeCard: View {
	let recipe: Recipe

	var body: some View {
		VStack(alignment: .leading, spacing: 12) {
			// Title
			Text(recipe.title)
				.font(.headline)
				.foregroundColor(AppColors.contentPrimary)
				.lineLimit(2)
			
			HStack(spacing: 16) {
				// Cook Time
				if let amount = recipe.cookTimeAmount, let unit = recipe.cookTimeUnit {
					Label {
						Text("\(Int(amount)) \(unit)")
							.font(.subheadline)
							.foregroundColor(AppColors.contentSecondary)
					} icon: {
						Image(systemName: "clock")
							.foregroundColor(AppColors.brandBase)
					}
				}
				
				// Ingredients Count
				Label {
					Text("\(recipe.ingredients.count) ingredients")
						.font(.subheadline)
						.foregroundColor(AppColors.contentSecondary)
				} icon: {
					Image(systemName: "list.bullet")
						.foregroundColor(AppColors.brandBase)
				}
			}
		}
		.padding()
		.frame(maxWidth: .infinity, alignment: .leading)
		.background(AppColors.backgroundPrimary)
		.cornerRadius(12)
		.overlay(
			RoundedRectangle(cornerRadius: 12)
				.stroke(AppColors.backgroundSecondary, lineWidth: 1)
		)
		.shadow(color: AppColors.shadow.opacity(0.1), radius: 2, y: 1)
	}
}

// Preview
struct RecipeCard_Previews: PreviewProvider {
	static var previews: some View {
		RecipeCard(recipe: mockRecipe)
			.padding()
	}
}
