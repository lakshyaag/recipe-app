//
//  IngredientsGrid.swift
//  recipe-view
//
//  Created by Lakshya Agarwal on 2025-01-04.
//

import SwiftUI

struct IngredientsGridView: View {
	let ingredients: [String]
	private let columns = Array(repeating: GridItem(.flexible(), spacing: 8), count: 3)
	
	var body: some View {
		ScrollView {
			LazyVGrid(columns: columns, alignment: .leading, spacing: 12) {
				ForEach(ingredients.indices, id: \.self) { index in
					IngredientCell(text: ingredients[index], index: index + 1)
				}
			}
		}
	}
}

struct IngredientCell: View {
	let text: String
	let index: Int
	@State private var isPressed = false
	
	var body: some View {
		Text(text)
			.font(.callout)
			.foregroundColor(AppColors.text)
			.lineLimit(3)
			.multilineTextAlignment(.leading)
			.frame(maxWidth: .infinity, alignment: .leading)
			.padding(.horizontal, 12)
			.padding(.vertical, 8)
			.background {
				RoundedRectangle(cornerRadius: 8, style: .continuous)
					.fill(AppColors.cardBackground)
			}
			.overlay {
				RoundedRectangle(cornerRadius: 8, style: .continuous)
					.strokeBorder(AppColors.primary.opacity(0.2), lineWidth: 1)
			}
			.contentShape(RoundedRectangle(cornerRadius: 8))
			.scaleEffect(isPressed ? 0.98 : 1.0)
			.animation(.spring(response: 0.3), value: isPressed)
			.pressEvents {
				withAnimation(.easeInOut(duration: 0.2)) {
					isPressed = true
				}
			} onRelease: {
				withAnimation(.easeInOut(duration: 0.2)) {
					isPressed = false
				}
			}
	}
}

// Custom ViewModifier for press events
struct PressActions: ViewModifier {
	var onPress: () -> Void
	var onRelease: () -> Void
	
	func body(content: Content) -> some View {
		content
			.simultaneousGesture(
				DragGesture(minimumDistance: 0)
					.onChanged { _ in onPress() }
					.onEnded { _ in onRelease() }
			)
	}
}

extension View {
	func pressEvents(onPress: @escaping () -> Void, onRelease: @escaping () -> Void) -> some View {
		modifier(PressActions(onPress: onPress, onRelease: onRelease))
	}
}

#Preview {
	IngredientsGridView(ingredients: [
		"2 tablespoons olive oil",
		"1 pound potatoes",
		"Salt and pepper",
		"1 onion, diced",
		"2 cloves garlic",
		"Fresh herbs"
	])
	.padding()
	.background(AppColors.background)
}
