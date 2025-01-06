//
//  InstructionsView.swift
//  recipe-view
//
//  Created by Lakshya Agarwal on 2025-01-05.
//

import ActivityKit
import SwiftUI

struct InstructionsSection: View {
	let instructions: [InstructionWithTime]
	@State private var currentStep = 0
	@State private var timer: Timer?
	@State private var timerValue: Int = 60
	@State private var activity: Activity<TimerAttributes>?

	func startTimer() {
		timer?.invalidate()
		timerValue = 60
		startLiveActivity()
		timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
			if timerValue > 0 {
				timerValue -= 1
				updateLiveActivity()
			} else {
				timer?.invalidate()
				endLiveActivity()
			}
		}
	}

	func setupLiveActivity() {
		// Initial setup for Live Activities if needed
	}

	func startLiveActivity() {
		let attributes = TimerAttributes(name: "Recipe Timer")
		let initialContentState = TimerAttributes.ContentState(remainingTime: timerValue)

		do {
			activity = try Activity<TimerAttributes>.request(
				attributes: attributes,
				contentState: initialContentState,
				pushType: nil
			)
		} catch {
			print("Failed to start Live Activity: \(error)")
		}
	}

	func updateLiveActivity() {
		let updatedContentState = TimerAttributes.ContentState(remainingTime: timerValue)
		Task {
			await activity?.update(using: updatedContentState)
		}
	}

	func endLiveActivity() {
		Task {
			await activity?.end(dismissalPolicy: .immediate)
		}
	}

	var body: some View {
		VStack(alignment: .leading, spacing: 24) {
			// Progress Bar
			GeometryReader { geometry in
				let stepWidth = geometry.size.width / CGFloat(instructions.count)
				ZStack(alignment: .leading) {
					// Background track
					RoundedRectangle(cornerRadius: 2)
						.fill(AppColors.contentSecondary.opacity(0.2))
						.frame(height: 4)

					// Progress indicator
					RoundedRectangle(cornerRadius: 2)
						.fill(AppColors.brandBase)
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
					.foregroundColor(AppColors.contentSecondary)

				Spacer()

				if let timeAmount = instructions[currentStep].timeAmount,
					let timeUnit = instructions[currentStep].timeUnit
				{
					Label {
						Text("\(timeAmount, specifier: "%.0f") \(timeUnit)")
							.font(.subheadline.weight(.medium))
					} icon: {
						Image(systemName: "timer")
							.foregroundStyle(AppColors.brandBase)
					}
					Button(action: startTimer) {
						Text("Start Timer")
					}
					.padding(.horizontal)

					.foregroundColor(AppColors.contentSecondary)
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
									.foregroundColor(AppColors.contentPrimary)
									.lineSpacing(8)
									.multilineTextAlignment(.leading)
									.padding(.horizontal)
									.padding(.vertical, 24)
									.frame(maxWidth: .infinity, alignment: .leading)
									.adaptiveBackgroundColor(
										AppColors.groupedBackgroundSecondary,
										dark: AppColors.backgroundTertiary
									)
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
											.foregroundColor(AppColors.actionPrimary)
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
											.foregroundColor(AppColors.actionPrimary)
											.padding(.vertical, 8)
										}
									}

									if idx == instructions.count - 1 {
										Button(action: {
											withAnimation {
												currentStep = 0
											}
										}) {
											HStack(spacing: 8) {
												Text("Start Over")
												Image(systemName: "arrow.2.circlepath")
											}
											.foregroundColor(AppColors.actionPrimary)
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
	.background(AppColors.groupedBackground)
}
