//
//  InstructionsView.swift
//  recipe-view
//
//  Created by Lakshya Agarwal on 2025-01-05.
//

import SwiftUI
import ActivityKit
import UserNotifications

struct InstructionsSection: View {
	let instructions: [InstructionWithTime]
	let recipeName: String
	@State private var currentStep = 0
	@State private var currentActivity: Activity<RecipeTimerAttributes>? = nil
	
	func startTimer() {
		guard let timeAmount = instructions[currentStep].timeAmount,
			  let timeUnit = instructions[currentStep].timeUnit else { return }
		
		let timeInterval: TimeInterval
		switch timeUnit.lowercased() {
		case "minutes", "minute", "mins", "min":
			timeInterval = timeAmount * 60
		case "hours", "hour", "hrs", "hr":
			timeInterval = timeAmount * 3600
		default:
			timeInterval = timeAmount
		}
		
		let attributes = RecipeTimerAttributes(
			stepDescription: instructions[currentStep].description,
			timeAmount: timeAmount,
			timeUnit: timeUnit
		)
		
		let contentState = RecipeTimerAttributes.ContentState(
			endTime: Date().addingTimeInterval(timeInterval),
			stepNumber: currentStep + 1,
			recipeName: recipeName
		)
		
		do {
			// Start the Live Activity
			let activity = try Activity.request(
				attributes: attributes,
				contentState: contentState,
				pushType: nil
			)
			currentActivity = activity
			
			// Schedule a notification for when the timer starts
			let startContent = UNMutableNotificationContent()
			startContent.title = "Timer Started"
			startContent.body = "Step \(currentStep + 1): \(instructions[currentStep].description)"
			startContent.sound = .default
			startContent.interruptionLevel = .critical
			
			let startRequest = UNNotificationRequest(
				identifier: "timer-start-\(currentStep)",
				content: startContent,
				trigger: nil
			)
			
			// Schedule a notification for when the timer completes
			let completionContent = UNMutableNotificationContent()
			completionContent.title = "Timer Complete!"
			completionContent.body = "Step \(currentStep + 1) is ready"
			completionContent.sound = .default
			
			let completionTrigger = UNTimeIntervalNotificationTrigger(
				timeInterval: timeInterval,
				repeats: false
			)
			
			let completionRequest = UNNotificationRequest(
				identifier: "timer-complete-\(currentStep)",
				content: completionContent,
				trigger: completionTrigger
			)
			
			// Add both notifications
			UNUserNotificationCenter.current().add(startRequest)
			UNUserNotificationCenter.current().add(completionRequest)
			
		} catch {
			print("Error starting timer: \(error.localizedDescription)")
		}
	}
	
	func cleanupTimer() {
		// End the Live Activity if it exists
		Task {
			await currentActivity?.end(using: nil, dismissalPolicy: .immediate)
		}
		
		// Remove any pending notifications for this step
		UNUserNotificationCenter.current().removePendingNotificationRequests(
			withIdentifiers: ["timer-start-\(currentStep)", "timer-complete-\(currentStep)"]
		)
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
				   let timeUnit = instructions[currentStep].timeUnit {
					Button {
						startTimer()
					} label: {
						Label {
							Text("\(timeAmount, specifier: "%.0f") \(timeUnit)")
								.font(.subheadline.weight(.medium))
						} icon: {
							Image(systemName: "timer")
								.foregroundStyle(AppColors.brandBase)
						}
						.foregroundColor(AppColors.contentSecondary)
					}
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
									.adaptiveBackgroundColor(AppColors.groupedBackgroundSecondary, dark: AppColors.backgroundTertiary)
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
										Button (action: {
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
		.onDisappear {
			cleanupTimer()
		}
	}
}

#Preview {
	ScrollView {
		InstructionsSection(instructions: mockRecipe.instructions, recipeName: "Test Recipe")
			.padding()
	}
	.background(AppColors.groupedBackground)
}

