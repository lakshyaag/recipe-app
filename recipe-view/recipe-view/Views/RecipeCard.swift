import SwiftUI

struct RecipeCard: View {
	let recipe: Recipe
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(recipe.name)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.primary)
            
            Text(recipe.description)
                .font(.body)
                .foregroundColor(.secondary)
                .lineLimit(4)
                .multilineTextAlignment(.leading)
            
            HStack {
                Text("Source:")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                Text(recipe.url)
                    .font(.subheadline)
                    .foregroundColor(AppColors.primary)
                    .lineLimit(1)
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
