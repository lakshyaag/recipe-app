//
//  RecipeTimerWidgetLiveActivity.swift
//  RecipeTimerWidget
//
//  Created by Lakshya Agarwal on 2025-01-05.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct RecipeTimerWidgetLiveActivity: Widget {
	var body: some WidgetConfiguration {
		ActivityConfiguration(for: RecipeTimerAttributes.self) { context in
			// Lock screen/banner UI
			LockScreenLiveActivityView(context: context)
				.activityBackgroundTint(Color.orange.opacity(0.2))
				.activitySystemActionForegroundColor(.white)
		} dynamicIsland: { context in
			DynamicIsland {
				// Expanded UI
				DynamicIslandExpandedRegion(.leading) {
					Image(systemName: "fork.knife")
						.foregroundStyle(.white)
						.frame(width: 20, height: 20)
				}
				
				DynamicIslandExpandedRegion(.trailing) {
					ProgressView(timerInterval: Date()...context.state.endTime, countsDown: true)
						.frame(width: 20, height: 20)
						.progressViewStyle(.circular)
						.tint(AppColors.brandBase)
				}
				
				DynamicIslandExpandedRegion(.center) {
					VStack(alignment: .leading, spacing: 4) {
						Text(context.attributes.stepDescription)
							.font(.subheadline)
							.foregroundStyle(.white.opacity(0.8))
							.lineLimit(1)
						
						Text("\(context.state.recipeName) - Step \(context.state.stepNumber)")
							.font(.caption)
							.foregroundStyle(.white)
					}
				}
				
			} compactLeading: {
				Label {
					Text(timerInterval: Date()...context.state.endTime, showsHours: true)
						.monospacedDigit()
						.foregroundStyle(AppColors.brandBase)
						.font(.headline)
				} icon: {
					Image(systemName: "timer")
						.foregroundStyle(AppColors.brandBase)
				}
			} compactTrailing: {
				Label {
					Text("Step \(context.state.stepNumber)")
						.font(.headline)
						.foregroundStyle(.white)
				} icon: {
					Image(systemName: "list.number")
						.foregroundStyle(.white)
				}
			} minimal: {
				Image(systemName: "timer")
					.foregroundStyle(.white)
			}.keylineTint(AppColors.brandBase)
		}
	}
}

// Lock screen/Notification Center view
struct LockScreenLiveActivityView: View {
	let context: ActivityViewContext<RecipeTimerAttributes>
	
	var body: some View {
		ZStack {
			RoundedRectangle(cornerRadius: 15)
				.fill(AppColors.actionGradient)
			
			VStack(alignment: .center, spacing: 12) {
				HStack {
					Label {
						Text("Step \(context.state.stepNumber)")
							.font(.headline)
							.foregroundStyle(.white)
					} icon: {
						Image(systemName: "list.number")
							.foregroundStyle(.white)
					}
					
					Spacer()
					
					Label(context.state.recipeName, systemImage: "fork.knife")
						.font(.headline)
						.foregroundStyle(.white)
				}
				
				Text(timerInterval: Date()...context.state.endTime, showsHours: true)
					.font(.system(.largeTitle, design: .rounded, weight: .bold))
					.monospacedDigit()
					.foregroundStyle(.white)
					.frame(maxWidth: .infinity)
				
				Text(context.attributes.stepDescription)
					.font(.title3)
					.foregroundStyle(.white.opacity(0.8))
					.multilineTextAlignment(.center)
					.lineLimit(2)
					.frame(maxWidth: .infinity, alignment: .center)
			}
			.padding()
		}
	}
}

// Preview helper
extension RecipeTimerAttributes {
	static var preview: RecipeTimerAttributes {
		RecipeTimerAttributes(
			stepDescription: "Preheat the oven to 350°F (175°C)",
			timeAmount: 5,
			timeUnit: "minutes"
		)
	}
}

extension RecipeTimerAttributes.ContentState {
	static var preview: RecipeTimerAttributes.ContentState {
		RecipeTimerAttributes.ContentState(
			endTime: Date().addingTimeInterval(360),
			stepNumber: 1,
			recipeName: "Chocolate Cake"
		)
	}
}

// Previews
#Preview("Notification", as: .content, using: RecipeTimerAttributes.preview) {
	RecipeTimerWidgetLiveActivity()
} contentStates: {
	RecipeTimerAttributes.ContentState.preview
}
