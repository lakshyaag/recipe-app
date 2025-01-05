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
		VStack(alignment: .leading, spacing: 24) {
			// Section Header
			Label("Instructions", systemImage: "list.bullet.clipboard.fill")
				.font(.system(.title2, design: .rounded, weight: .semibold))
				.foregroundStyle(AppColors.text)
				.symbolRenderingMode(.hierarchical)
				.padding(.horizontal)
			
			// Progress Bar
			GeometryReader { geometry in
				let stepWidth = geometry.size.width / CGFloat(instructions.count)
				ZStack(alignment: .leading) {
					// Background track
					RoundedRectangle(cornerRadius: 2)
						.fill(AppColors.secondaryText.opacity(0.2))
						.frame(height: 4)
					
					// Progress indicator
					RoundedRectangle(cornerRadius: 2)
						.fill(AppColors.primary)
						.frame(width: stepWidth * CGFloat(currentStep + 1), height: 4)
						.animation(.spring(response: 0.3), value: currentStep)
				}
			}
			.frame(height: 4)
			.padding(.horizontal)
			
			// Step Counter
			HStack {
				Text("Step \(currentStep + 1) of \(instructions.count)")
					.font(.subheadline.weight(.medium))
					.foregroundColor(AppColors.secondaryText)
				
				Spacer()
				
				if let timeAmount = instructions[currentStep].timeAmount,
				   let timeUnit = instructions[currentStep].timeUnit {
					Label {
						Text("\(timeAmount, specifier: "%.0f") \(timeUnit)")
							.font(.subheadline.weight(.medium))
					} icon: {
						Image(systemName: "timer")
							.foregroundStyle(AppColors.primary)
					}
					.foregroundColor(AppColors.secondaryText)
				}
			}
			.padding(.horizontal)
			
			// Instructions Card
			TabView(selection: $currentStep) {
				ForEach(instructions.indices, id: \.self) { idx in
					VStack(alignment: .leading, spacing: 20) {
						ScrollView {
							VStack(alignment: .leading, spacing: 16) {
								// Step Description
								Text(instructions[idx].description)
									.font(.body)
									.foregroundColor(AppColors.text)
									.lineSpacing(8)
									.multilineTextAlignment(.leading)
									.padding(.horizontal)
									.padding(.vertical, 24)
									.frame(maxWidth: .infinity, alignment: .leading)
									.background(AppColors.cardBackground)
									.cornerRadius(16)
								
								// Navigation Buttons
								HStack {
									if idx > 0 {
										Button(action: {
											withAnimation {
												currentStep = idx - 1
											}
										}) {
											HStack(spacing: 8) {
												Image(systemName: "chevron.left")
												Text("Previous Step")
											}
											.foregroundColor(AppColors.primary)
											.padding(.vertical, 8)
										}
									}
									
									Spacer()
									
									if idx < instructions.count - 1 {
										Button(action: {
											withAnimation {
												currentStep = idx + 1
											}
										}) {
											HStack(spacing: 8) {
												Text("Next Step")
												Image(systemName: "chevron.right")
											}
											.foregroundColor(AppColors.primary)
											.padding(.vertical, 8)
										}
									}
								}
								.padding(.horizontal)
							}
						}
					}
					.tag(idx)
				}
			}
			.tabViewStyle(.page(indexDisplayMode: .never))
			.frame(minHeight: 300)
		}
		.padding(.vertical)
	}
}

#Preview {
	ScrollView {
		InstructionsSection(instructions: mockRecipe.instructions)
			.padding()
	}
	.background(AppColors.background)
}

