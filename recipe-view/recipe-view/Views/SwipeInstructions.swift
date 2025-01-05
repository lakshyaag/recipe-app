//
//  SwipeInstructions.swift
//  recipe-view
//
//  Created by Lakshya Agarwal on 2025-01-04.
//

import SwiftUI

struct SwipeInstructionsView: View {
	let instructions: [String]
	@State private var currentStep = 0
	
	var body: some View {
		VStack(spacing: 16) {
			// Step indicator dots
			HStack(spacing: 6) {
				ForEach(0..<instructions.count, id: \.self) { index in
					Circle()
						.fill(index == currentStep ? AppColors.primary : AppColors.secondaryText.opacity(0.3))
						.frame(width: 8, height: 8)
				}
			}
			.padding(.top, 8)
			
			// Swipeable steps
			TabView(selection: $currentStep) {
				ForEach(instructions.indices, id: \.self) { idx in
					ScrollView(showsIndicators: false) {
						VStack(spacing: 16) {
							// Step header
							HStack {
								Label {
									Text("Step \(idx + 1)")
										.font(.headline)
										.foregroundColor(AppColors.primary)
								} icon: {
									Text("\(idx + 1)")
										.font(.caption.bold())
										.foregroundColor(.white)
										.frame(width: 24, height: 24)
										.background(AppColors.primary)
										.clipShape(Circle())
								}
								
								Spacer()
								
								Text("\(idx + 1) of \(instructions.count)")
									.font(.caption)
									.foregroundColor(AppColors.secondaryText)
							}
							
							// Step content
							Text(instructions[idx])
								.font(.body)
								.foregroundColor(AppColors.text)
								.lineSpacing(4)
								.multilineTextAlignment(.leading)
								.fixedSize(horizontal: false, vertical: true)
						}
						.padding(16)
						.frame(maxWidth: .infinity, alignment: .leading)
						.background(AppColors.cardBackground)
						.cornerRadius(12)
					}
					.padding(.horizontal)
					.tag(idx)
				}
			}
			.tabViewStyle(.page(indexDisplayMode: .never))
			.frame(height: 250)
		}
	}
}

#Preview {
	SwipeInstructionsView(instructions: [
		"First step of the recipe with detailed instructions that might be quite long and need multiple lines to display properly. This is a very long instruction to test the scrolling behavior.",
		"Second step with more details about what to do. Adding more text to ensure we can see how the scrolling works with longer content.",
		"Final step to complete the recipe. This step also contains detailed instructions that might need multiple lines to display properly."
	])
	.padding()
	.background(AppColors.background)
}
