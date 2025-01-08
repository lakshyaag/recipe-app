import Foundation

struct Recipe: Decodable {
    let id: String
    let title: String
    let ingredients: [Ingredient]
    let instructions: [InstructionWithTime]
    let cookTimeAmount: Double?
    let cookTimeUnit: String?
	let servingsAmount: Double?
	let servingsUnit: String?
	let difficulty: String?
    let createdAt: String
    let updatedAt: String
    let userId: String?
    let url: String
    let urlHash: String	
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case ingredients
        case instructions
        case cookTimeAmount = "cook_time_amount"
        case cookTimeUnit = "cook_time_unit"
		case servingsAmount = "servings_amount"
		case servingsUnit = "servings_unit"
        case difficulty
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case userId = "user_id"
        case url
        case urlHash = "url_hash"
    }
}

struct Ingredient: Decodable, Identifiable {
    let item: String
    let amount: Double
    let unit: String
    let category: Category
    let preparation: String?
    let isOptional: Bool
    let notes: String?
    
    var id: String { item }
    
    enum Category: String, Decodable {
        case protein = "protein"
        case grains = "grains"
        case produce = "produce"
        case oils = "oils"
        case condiments = "condiments"
        case spices = "spices"
        case sauces = "sauces"
        case dairy = "dairy"
        case herbs = "herbs"
        case other = "other"
        
        var displayName: String {
            rawValue.capitalized
        }
        
        // Static mapping of emojis
        static let categoryEmojis: [Category: String] = [
            .protein: "🥩",
            .grains: "🌾",
            .produce: "🥬",
            .oils: "🫗",
            .condiments: "🧂",
            .spices: "🌶️",
            .sauces: "🥫",
            .dairy: "🥛",
            .herbs: "🌿",
            .other: "📦"
        ]
        
        var emoji: String {
            Category.categoryEmojis[self] ?? "📦"
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case item
        case amount
        case unit
        case category
        case preparation
        case isOptional = "is_optional"
        case notes
    }
}

struct InstructionWithTime: Decodable, Identifiable {
    let id: String
    let recipeId: String
    let step: Int
    let description: String
    let timeAmount: Double?
    let timeUnit: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case recipeId = "recipe_id"
        case step = "step_number"
        case description
        case timeAmount = "time_amount"
        case timeUnit = "time_unit"
    }
}

struct Time: Decodable {
    let amount: Double
    let unit: String
}
