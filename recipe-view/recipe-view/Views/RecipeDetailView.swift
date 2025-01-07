import SwiftUI

enum RecipeTab {
	case ingredients
	case instructions
	
	var title: String {
		switch self {
		case .ingredients: return "Ingredients"
		case .instructions: return "Instructions"
		}
	}
	
	var icon: String {
		switch self {
		case .ingredients: return "list.bullet"
		case .instructions: return "text.justify"
		}
	}
}

struct RecipeDetailView: View {
	let recipe: Recipe
	@State private var selectedTab: RecipeTab = .ingredients
	
	var body: some View {
		ScrollView {
			VStack(spacing: 0) {
				// Hero Section
				RecipeHeroView(recipe: recipe)
					.padding(.bottom, -20)
				
				// Content Section
				VStack(spacing: 24) {
					// Quick Stats
					RecipeStatsView(recipe: recipe)
						.padding(.horizontal)
						.padding(.top, 32)
					
					// Original Recipe Link
					Link(destination: URL(string: recipe.url)!) {
						HStack {
							Text("View Original Recipe")
							Image(systemName: "arrow.up.right")
						}
						.font(.subheadline.weight(.medium))
						.foregroundColor(AppColors.brandBase)
					}
					
					// Native Picker
					Picker("Section", selection: $selectedTab) {
						Text("Ingredients").tag(RecipeTab.ingredients)
						Text("Instructions").tag(RecipeTab.instructions)
					}
					.pickerStyle(.segmented)
					.padding(.horizontal)
					
					// Content based on selection
					ZStack {
						if selectedTab == .ingredients {
							IngredientsSection(ingredients: recipe.ingredients)
								.transition(
									.asymmetric(
										insertion: .move(edge: .leading).combined(with: .opacity),
										removal: .move(edge: .trailing).combined(with: .opacity)
									)
								)
						}
						
						if selectedTab == .instructions {
							InstructionsSection(
								instructions: recipe.instructions, recipeName: recipe.title
							)
							.transition(
								.asymmetric(
									insertion: .move(edge: .trailing).combined(with: .opacity),
									removal: .move(edge: .leading).combined(with: .opacity)
								)
							)
						}
					}
					.animation(.spring(response: 0.3, dampingFraction: 0.8), value: selectedTab)
				}
				.background(AppColors.backgroundPrimary)
				.clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
			}
		}
		.ignoresSafeArea(edges: .top)
		.navigationBarTitleDisplayMode(.inline)
	}
}

struct DetailRow: View {
	let icon: String
	let title: String
	let value: String
	
	var body: some View {
		HStack(spacing: 12) {
			Image(systemName: icon)
				.font(.system(size: 20))
				.foregroundColor(AppColors.brandBase)
				.frame(width: 24)
			
			Text(title)
				.foregroundColor(AppColors.contentSecondary)
			
			Spacer()
			
			Text(value)
				.foregroundColor(AppColors.contentPrimary)
				.fontWeight(.medium)
		}
	}
}

// MARK: - Hero View
struct RecipeHeroView: View {
	let recipe: Recipe
	
	var body: some View {
		ZStack(alignment: .bottomLeading) {
			// Background with gradient
			LinearGradient(
				colors: [
					AppColors.brandBase,
					AppColors.brandBase.opacity(0.8)
				],
				startPoint: .topLeading,
				endPoint: .bottomTrailing
			)
			.frame(height: 200)
			
			
			
			// Title
			Text(recipe.title)
				.font(.title.bold())
				.foregroundColor(.white)
				.multilineTextAlignment(.leading)
			
			
				.padding(24)
		}
		.clipShape(RoundedRectangle(cornerRadius: 0))
	}
}

// MARK: - Stats View
struct RecipeStatsView: View {
	let recipe: Recipe
	
	var body: some View {
		HStack(spacing: 24) {
			// Servings
			StatItem(
				icon: "person.2",
				value: "\(Int(recipe.servingsAmount ?? 0))",
				unit: recipe.servingsUnit ?? ""
			)
			
			// Ingredients
			StatItem(
				icon: "list.bullet",
				value: "\(recipe.ingredients.count)",
				unit: "ingredients"
			)
			
			if let difficulty = recipe.difficulty {
				let difficultyInfo = DifficultyInfo.info(for: difficulty)
				StatItem(
					icon: difficultyInfo.icon,
					value: difficultyInfo.displayText,
					unit: "Difficulty",
					iconColor: difficultyInfo.color
				)
			}
		}
		.padding(20)
		.background(AppColors.backgroundSecondary)
		.clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
	}
}

// MARK: - Supporting Views
struct StatItem: View {
	let icon: String
	let value: String
	let unit: String
	var iconColor: Color = AppColors.brandBase

	var body: some View {
		VStack(spacing: 4) {
			// Icon and value in an HStack
			HStack(alignment: .center, spacing: 8) {
				Image(systemName: icon)
					.font(.system(size: 24))
					.foregroundColor(iconColor)
					.frame(width: 24, height: 24, alignment: .center)

				Text(value)
					.font(.subheadline.bold())
					.foregroundColor(AppColors.contentPrimary)
					.lineLimit(1)
					.minimumScaleFactor(0.4)
			}
			.frame(maxWidth: .infinity)

			// Unit text
			Text(unit)
				.font(.caption)
				.foregroundColor(AppColors.contentSecondary)
		}
		.frame(maxWidth: .infinity) // Ensure the VStack takes full width
		.multilineTextAlignment(.center) // Center-align text
	}
}

struct SectionHeader: View {
	let title: String
	let icon: String
	
	var body: some View {
		HStack(spacing: 8) {
			Image(systemName: icon)
				.foregroundColor(AppColors.brandBase)
			Text(title)
				.font(.title3.bold())
				.foregroundColor(AppColors.contentPrimary)
		}
	}
}

// Add extension for Difficulty display properties
struct DifficultyInfo {
	let displayText: String
	let color: Color
	let icon: String
	
	static func info(for difficulty: String) -> DifficultyInfo {
		switch difficulty {
		case "novice":
			return DifficultyInfo(displayText: "Low", color: .green, icon: "gauge.low")
		case "home_cook":
			return DifficultyInfo(displayText: "Medium", color: .orange, icon: "gauge.medium")
		case "professional_chef":
			return DifficultyInfo(displayText: "High", color: .red, icon: "gauge.high")
		default:
			return DifficultyInfo(displayText: "Unknown", color: .gray, icon: "questionmark")
		}
	}
}

#Preview {
	RecipeDetailView(recipe: mockRecipe)
		.padding()
}
