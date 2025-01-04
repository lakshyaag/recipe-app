import Foundation

struct Recipe: Decodable {
    
    let title: String
    let ingredients: [String]
    let instructions: [String]
	let cookTime: String?
	let difficulty: String?
	
    
    static let mockRecipe = Recipe(
        title: "Delicious Pasta Carbonara",
        ingredients: ["Pasta", "Eggs", "Cheese", "Pancetta", "Black Pepper"],
        instructions: [
            "Boil pasta.",
            "Cook pancetta.",
            "Mix eggs and cheese.",
            "Combine all ingredients."
        ],
		cookTime: "15 minutes",
		difficulty: "Easy"
    )
} 
