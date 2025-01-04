import Foundation

struct Recipe: Identifiable, Decodable {
    let id = UUID()
    let name: String
    let description: String
    let url: String
	
	private enum CodingKeys: String, CodingKey {
		case name
		case description
		case url
	}
    
    static let mockRecipe = Recipe(
        name: "Delicious Pasta Carbonara",
        description: "A classic Italian pasta dish made with eggs, cheese, pancetta, and black pepper. This creamy pasta dish is quick to make and absolutely delicious.",
        url: "https://example.com/pasta-carbonara"
    )
} 
