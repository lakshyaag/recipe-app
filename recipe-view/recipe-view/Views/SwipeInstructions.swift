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
	@State private var expandedStep: Int? = nil
	
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
					ScrollView {
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
							VStack(alignment: .leading, spacing: 8) {
								Text(instructions[idx])
									.font(.body)
									.foregroundColor(AppColors.text)
									.lineSpacing(4)
									.lineLimit(expandedStep == idx ? nil : 3)
									.multilineTextAlignment(.leading)
								
								if expandedStep != idx {
									Button {
										withAnimation(.easeInOut(duration: 0.3)) {
											expandedStep = idx
										}
									} label: {
										Text("Show More")
											.font(.footnote.bold())
											.foregroundColor(AppColors.primary)
									}
								} else {
									Button {
										withAnimation(.easeInOut(duration: 0.3)) {
											expandedStep = nil
										}
									} label: {
										Text("Show Less")
											.font(.footnote.bold())
											.foregroundColor(AppColors.primary)
									}
								}
							}
						}
						.padding(16)
						.frame(maxWidth: .infinity, alignment: .leading)
						.background(AppColors.cardBackground)
						.cornerRadius(12)
						.shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
						.padding(.horizontal)
					}
					.tag(idx)
				}
			}
			.tabViewStyle(.page(indexDisplayMode: .never))
			.frame(minHeight: 200)
		}
	}
}

#Preview {
	SwipeInstructionsView(instructions: [
		"First step of the recipe with detailed instructions that might be quite long and need multiple lines to display properly. Adding more text to show how the expansion works with longer content that needs to be displayed properly. This is an even longer step to really test the expansion behavior with multiple lines of text that should be hidden initially.",
		"Second step with more details about what to do. This step also has quite a bit of content to demonstrate the expansion behavior. Adding some more text to make it longer and test the expansion properly.",
		"Final step to complete the recipe. Making this one a bit longer as well to test the expansion functionality properly. This step should also have enough content to demonstrate the expansion behavior."
	])
	.padding()
	.background(AppColors.background)
}
