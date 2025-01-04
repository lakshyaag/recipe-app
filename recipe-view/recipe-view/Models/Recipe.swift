import Foundation

struct Recipe: Decodable {

    let title: String
    let ingredients: [String]
    let instructions: [String]
    let cookTime: String?
    let difficulty: String?

    static let mockRecipe = Recipe(
        title: "Ground Beef and Potatoes",
        ingredients: [
            "2 tablespoons canola oil",
            "1 pound potatoes, peeled and diced into 1-inch cubes",
            "1 pound 93% lean ground beef",
            "1 small yellow onion, diced",
            "1 red bell pepper, diced",
            "1 tablespoon Worcestershire sauce",
            "1 teaspoon Dijon mustard",
            "2 teaspoons smoked paprika",
            "1 teaspoon garlic powder",
            "1 teaspoon dried oregano",
            "1 teaspoon kosher salt plus additional to taste",
            "1/2 teaspoon ground black pepper",
            "1 to 2 teaspoons hot sauce plus additional for serving",
            "2 green onions, sliced",
        ],
        instructions: [
            "Heat the oil in a skillet large enough to hold all of the ingredients over high heat. Once the oil is hot and shiny, reduce the heat to medium, then add the potatoes. Cook, stirring often, until the potatoes are turning golden and becoming tender (they should still be too firm to eat), about 6 minutes.",
            "Add the beef, onion, and bell pepper. Cook, breaking apart the meat. Add the Worcestershire, mustard, smoked paprika, garlic powder, oregano, salt, pepper, and hot sauce (add 1 teaspoon if you prefer only subtle heat, more if you would like it spicier).",
            "Continue cooking and breaking up the beef, until the potatoes and onions are tender and the meat is fully cooked through, about 6 to 8 minutes more. Stir in the green onions. Taste and adjust the salt and pepper as desired. Serve hot, topped with Greek yogurt, cheese, over rice, or enjoy it all on its own with a dash of extra hot sauce if you like.",
        ],
        cookTime: "35 minutes",
        difficulty: "easy"

    )
}
