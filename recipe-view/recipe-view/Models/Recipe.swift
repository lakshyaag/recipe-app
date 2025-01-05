import Foundation

struct Recipe: Decodable {

    let title: String
    let ingredients: [Ingredient]
    let instructions: [InstructionWithTime]
    let cookTime: String?
    let difficulty: String?
}

struct Ingredient: Decodable {
    let item: String
    let amount: Double
    let unit: String
    let notes: String?
}

struct InstructionWithTime: Decodable {
    let step: Int
    let description: String
    let time: InstructionTime?
}

struct InstructionTime: Decodable {
    let amount: Double
    let unit: String
}
