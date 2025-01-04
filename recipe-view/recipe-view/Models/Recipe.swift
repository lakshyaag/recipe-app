import Foundation

struct Recipe: Identifiable {
    let id = UUID()
    let name: String
    let description: String
    let url: String
    
    static let mockRecipe = Recipe(
        name: "Delicious Pasta Carbonara",
        description: "A classic Italian pasta dish made with eggs, cheese, pancetta, and black pepper. This creamy pasta dish is quick to make and absolutely delicious.",
        url: "https://example.com/pasta-carbonara"
    )
} 