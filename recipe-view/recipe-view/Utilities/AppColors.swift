import SwiftUI

enum AppColors {
    static let primary = Color("RecipePrimary")
    static let secondary = Color("RecipePrimary").opacity(0.8)
    static let accent = Color("RecipeAccent")
    
    // System backgrounds
    static let background = Color(.systemGroupedBackground)
    static let cardBackground = Color(.secondarySystemGroupedBackground)
    
    // System semantic colors for text
    static let text = Color(.label)
    static let secondaryText = Color(.secondaryLabel)
    static let tertiaryText = Color(.tertiaryLabel)
	
	static let divider = Color(.secondarySystemBackground)
}
