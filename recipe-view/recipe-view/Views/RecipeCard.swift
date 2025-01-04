import SwiftUI

struct RecipeCard: View {
	let recipe: Recipe
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(recipe.title)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.primary)
            
            Text("Ingredients:")
                .font(.headline)
                .foregroundColor(.secondary)
            
            ForEach(recipe.ingredients, id: \.self) { ingredient in
                Text(ingredient)
                    .font(.body)
                    .foregroundColor(.secondary)
            }
            
            Text("Instructions:")
                .font(.headline)
                .foregroundColor(.secondary)
            
            ForEach(recipe.instructions, id: \.self) { instruction in
                Text(instruction)
                    .font(.body)
                    .foregroundColor(.secondary)
            }
        }
        .padding()
        .background(AppColors.cardBackground)
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
    }
}

#Preview {
    RecipeCard(recipe: Recipe.mockRecipe)
        .padding()
} 
