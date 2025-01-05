
let mockRecipe: Recipe = Recipe(
	title: "Brown Lentils",
	ingredients: [
		Ingredient(item: "brown lentils (whole masoor dal)", amount: 1, unit: "cup", notes: nil),
		Ingredient(item: "red lentils (optional)", amount: 0.5, unit: "cup", notes: nil),
		Ingredient(item: "water", amount: 4, unit: "cups", notes: nil),
		Ingredient(item: "oil/ghee", amount: 3, unit: "tablespoons", notes: nil),
		Ingredient(item: "cumin seeds", amount: 1, unit: "teaspoon", notes: nil),
		Ingredient(item: "fennel seeds (optional)", amount: 1, unit: "teaspoon", notes: nil),
		Ingredient(item: "dried red chilies", amount: 3, unit: "pieces", notes: nil),
		Ingredient(item: "onion (fine chopped)", amount: 1, unit: "cup", notes: nil),
		Ingredient(item: "ginger (minced)", amount: 1, unit: "tablespoon", notes: nil),
		Ingredient(item: "garlic (minced)", amount: 1, unit: "tablespoon", notes: nil),
		Ingredient(item: "tomato (fine chopped)", amount: 1, unit: "cup", notes: nil),
		Ingredient(item: "coriander leaves (chopped)", amount: 4, unit: "tablespoons", notes: nil),
		Ingredient(item: "organic turmeric", amount: 0.5, unit: "teaspoon", notes: nil),
		Ingredient(item: "kashmiri red chili powder", amount: 1, unit: "teaspoon", notes: nil),
		Ingredient(item: "sea salt", amount: 1, unit: "teaspoon", notes: nil),
		Ingredient(item: "dried fenugreek leaves (kasuri methi)", amount: 1, unit: "tablespoon", notes: nil),
		Ingredient(item: "amchur (dried mango powder or lemon juice)", amount: 1, unit: "tablespoon", notes: nil),
		Ingredient(item: "garam masala", amount: 1, unit: "teaspoon", notes: nil),
		Ingredient(item: "coriander powder (optional)", amount: 1, unit: "teaspoon", notes: nil),
		Ingredient(item: "cumin powder (optional)", amount: 0.5, unit: "teaspoon", notes: nil)
	],
	instructions: [
		InstructionWithTime(step: 1, description: "Rinse the brown lentils and red lentils in a large pot.", time:
InstructionTime(amount: 5, unit: "minutes")),
		InstructionWithTime(step: 2, description: "Pour 4 cups of water into the pot.", time: InstructionTime(amount: 1, unit:
"minute")),
		InstructionWithTime(step: 3, description: "Bring to a rolling boil on high heat, then reduce to medium.", time:
InstructionTime(amount: 5, unit: "minutes")),
		InstructionWithTime(step: 4, description: "Cook until tender, about 20 to 25 minutes.", time: InstructionTime(amount:
25, unit: "minutes")),
		InstructionWithTime(step: 5, description: "In a separate pan, heat oil/ghee and add cumin and fennel seeds.", time:
InstructionTime(amount: 2, unit: "minutes")),
		InstructionWithTime(step: 6, description: "Add dried red chilies and sauté until they turn crisp.", time:
InstructionTime(amount: 2, unit: "minutes")),
		InstructionWithTime(step: 7, description: "Add chopped onions and sauté until light golden.", time:
InstructionTime(amount: 5, unit: "minutes")),
		InstructionWithTime(step: 8, description: "Stir in minced ginger, garlic, and coriander leaves.", time:
InstructionTime(amount: 2, unit: "minutes")),
		InstructionWithTime(step: 9, description: "Add turmeric, salt, red chili powder, coriander powder, cumin powder, and garam masala.", time: InstructionTime(amount: 1, unit: "minute")),
		InstructionWithTime(step: 10, description: "Add chopped tomatoes and cook until they break down.", time:
InstructionTime(amount: 5, unit: "minutes")),
		InstructionWithTime(step: 11, description: "Add the cooked lentils along with their liquid and mix well.", time:
InstructionTime(amount: 2, unit: "minutes")),
		InstructionWithTime(step: 12, description: "Simmer for 5 minutes until thickened.", time: InstructionTime(amount: 5,
unit: "minutes")),
		InstructionWithTime(step: 13, description: "Stir in amchur and fenugreek leaves.", time: InstructionTime(amount: 1,
unit: "minute")),
		InstructionWithTime(step: 14, description: "Taste and adjust seasoning as needed.", time: InstructionTime(amount: 2,
unit: "minutes")),
		InstructionWithTime(step: 15, description: "Serve garnished with coriander leaves.", time: InstructionTime(amount: 1,
unit: "minute"))
	],
	cookTime: "30 minutes",
	difficulty: "easy"
)
