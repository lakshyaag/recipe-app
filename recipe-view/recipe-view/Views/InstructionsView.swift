//
//  InstructionsView.swift
//  recipe-view
//
//  Created by Lakshya Agarwal on 2025-01-05.
//

import SwiftUI

struct InstructionsSection: View {
	let instructions: [InstructionWithTime]
	@State private var currentStep = 0
	
	var body: some View {
		VStack(alignment: .leading, spacing: 16) {
			// Section Header
			Label("Instructions", systemImage: "list.bullet.clipboard.fill")
				.font(.system(.title2, design: .rounded, weight: .semibold))
				.foregroundStyle(AppColors.text)
				.symbolRenderingMode(.hierarchical)
			
			// Step Indicator Dots (Centered)
			HStack {
				Spacer()
				HStack(spacing: 6) {
					ForEach(0..<instructions.count, id: \.self) { index in
						Circle()
							.fill(index == currentStep ? AppColors.primary : AppColors.secondaryText.opacity(0.3))
							.frame(width: 8, height: 8)
					}
				}
				Spacer()
			}
			.padding(.top, 8)
			
			// Swipeable Steps
			TabView(selection: $currentStep) {
				ForEach(instructions.indices, id: \.self) { idx in
					HStack(alignment: .top, spacing: 16) {
						// Step Number (Circle on the Left)
						Text("\(instructions[idx].step)")
							.font(.caption.bold())
							.foregroundColor(.white)
							.frame(width: 24, height: 24)
							.background(AppColors.primary)
							.clipShape(Circle())
						
						// Step Description (Middle)
						Text(instructions[idx].description)
							.font(.body)
							.foregroundColor(AppColors.text)
							.lineSpacing(4)
							.multilineTextAlignment(.leading)
							.fixedSize(horizontal: false, vertical: true)
						
						// Time (Far Right)
						if let timeInfo = instructions[idx].time {
							VStack(spacing: 4) {
								Text("\(timeInfo.amount, specifier: "%.0f")")
									.font(.subheadline)
									.foregroundColor(AppColors.primary)
								Text(timeInfo.unit)
									.font(.caption)
									.foregroundColor(AppColors.secondaryText)
							}
							.padding(8)
							.background(AppColors.primary.opacity(0.1))
							.cornerRadius(8)
						}
					}
					.padding(16)
					.frame(maxWidth: .infinity, alignment: .leading)
					.background(AppColors.cardBackground)
					.cornerRadius(12)
					.tag(idx)
				}
			}
			.tabViewStyle(.page(indexDisplayMode: .never))
			.frame(height: 300) // Adjust height as needed
		}
		.padding(.horizontal)
		.padding(.vertical, 16)
	}
}

#Preview {
	ScrollView {
		InstructionsSection(instructions: mockRecipe.instructions)
			.padding()
	}
	.background(AppColors.background)
}

