import Foundation

struct Recipe: Identifiable, Decodable {
    let id = UUID()
    let title: String
    let ingredients: [String]
    let instructions: [String]
    
    private enum CodingKeys: String, CodingKey {
        case title
        case ingredients
        case instructions
    }
    
    static let mockRecipe = Recipe(
        title: "Delicious Pasta Carbonara",
        ingredients: ["Pasta", "Eggs", "Cheese", "Pancetta", "Black Pepper"],
        instructions: [
            "Boil pasta.",
            "Cook pancetta.",
            "Mix eggs and cheese.",
            "Combine all ingredients."
        ]
    )
} 
