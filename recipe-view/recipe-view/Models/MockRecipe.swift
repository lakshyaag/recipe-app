let mockRecipe: Recipe = Recipe(
	id: "mock-recipe-001",
	title: "Brown Lentils",
	ingredients: [
		Ingredient(item: "brown lentils (whole masoor dal)", amount: 1, unit: "cup", notes: "Soaked overnight"),
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
		Ingredient(item: "cumin powder (optional)", amount: 0.5, unit: "teaspoon", notes: nil),
	],
	instructions: [
		InstructionWithTime(
			id: "mock-instruction-001",
			recipeId: "mock-recipe-001",
			step: 1,
			description: "Rinse the brown lentils and red lentils in a large pot.",
			timeAmount: 5,
			timeUnit: "minutes"),
		InstructionWithTime(
			id: "mock-instruction-002",
			recipeId: "mock-recipe-001",
			step: 2,
			description: "Pour 4 cups of water into the pot.",
			timeAmount: 1,
			timeUnit: "minute"),
		InstructionWithTime(
			id: "mock-instruction-003",
			recipeId: "mock-recipe-001",
			step: 3,
			description: "Bring to a rolling boil on high heat, then reduce to medium.",
			timeAmount: 5,
			timeUnit: "minutes"),
		InstructionWithTime(
			id: "mock-instruction-004",
			recipeId: "mock-recipe-001",
			step: 4,
			description: "Cook until tender, about 20 to 25 minutes.",
			timeAmount: 25,
			timeUnit: "minutes"),
		InstructionWithTime(
			id: "mock-instruction-005",
			recipeId: "mock-recipe-001",
			step: 5,
			description: "In a separate pan, heat oil/ghee and add cumin and fennel seeds.",
			timeAmount: 2,
			timeUnit: "minutes"),
		InstructionWithTime(
			id: "mock-instruction-006",
			recipeId: "mock-recipe-001",
			step: 6,
			description: "Add dried red chilies and sauté until they turn crisp.",
			timeAmount: 2,
			timeUnit: "minutes"),
		InstructionWithTime(
			id: "mock-instruction-007",
			recipeId: "mock-recipe-001",
			step: 7,
			description: "Add chopped onions and sauté until light golden.",
			timeAmount: 5,
			timeUnit: "minutes"),
		InstructionWithTime(
			id: "mock-instruction-008",
			recipeId: "mock-recipe-001",
			step: 8,
			description: "Stir in minced ginger, garlic, and coriander leaves.",
			timeAmount: 2,
			timeUnit: "minutes"),
		InstructionWithTime(
			id: "mock-instruction-009",
			recipeId: "mock-recipe-001",
			step: 9,
			description: "Add turmeric, salt, red chili powder, coriander powder, cumin powder, and garam masala.",
			timeAmount: 1,
			timeUnit: "minute"),
		InstructionWithTime(
			id: "mock-instruction-010",
			recipeId: "mock-recipe-001",
			step: 10,
			description: "Add chopped tomatoes and cook until they break down.",
			timeAmount: 5,
			timeUnit: "minutes"),
		InstructionWithTime(
			id: "mock-instruction-011",
			recipeId: "mock-recipe-001",
			step: 11,
			description: "Add the cooked lentils along with their liquid and mix well.",
			timeAmount: 2,
			timeUnit: "minutes"),
		InstructionWithTime(
			id: "mock-instruction-012",
			recipeId: "mock-recipe-001",
			step: 12,
			description: "Simmer for 5 minutes until thickened.",
			timeAmount: 5,
			timeUnit: "minutes"),
		InstructionWithTime(
			id: "mock-instruction-013",
			recipeId: "mock-recipe-001",
			step: 13,
			description: "Stir in amchur and fenugreek leaves.",
			timeAmount: 1,
			timeUnit: "minute"),
		InstructionWithTime(
			id: "mock-instruction-014",
			recipeId: "mock-recipe-001",
			step: 14,
			description: "Taste and adjust seasoning as needed.",
			timeAmount: 2,
			timeUnit: "minutes"),
		InstructionWithTime(
			id: "mock-instruction-015",
			recipeId: "mock-recipe-001",
			step: 15,
			description: "Serve garnished with coriander leaves.",
			timeAmount: 1,
			timeUnit: "minute"),
	],
	cookTimeAmount: 30,
	cookTimeUnit: "minutes",
	difficulty: "easy",
	createdAt: "2024-01-05T21:24:58.074187+00:00",
	updatedAt: "2024-01-05T21:24:58.074187+00:00",
	userId: nil,
	url: "https://example.com/brown-lentils",
	urlHash: "mock-hash-001"
)
