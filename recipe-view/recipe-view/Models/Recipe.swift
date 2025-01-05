import Foundation

struct Recipe: Decodable {
    let id: String
    let title: String
    let ingredients: [Ingredient]
    let instructions: [InstructionWithTime]
    let cookTimeAmount: Double?
    let cookTimeUnit: String?
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
        case difficulty
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case userId = "user_id"
        case url
        case urlHash = "url_hash"
    }
}

struct Ingredient: Decodable {
    let item: String
    let amount: Double
    let unit: String
    let notes: String?
}

struct InstructionWithTime: Decodable {
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
