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
                    Label {
                        Text(context.state.recipeName)
                            .font(.caption)
                            .foregroundStyle(.white)
                    } icon: {
                        Image(systemName: "fork.knife")
                            .foregroundStyle(.white)
                    }
                }
                
                DynamicIslandExpandedRegion(.trailing) {
                    Label {
                        Text("Step \(context.state.stepNumber)")
                            .font(.caption)
                            .foregroundStyle(.white)
                    } icon: {
                        Image(systemName: "list.number")
                            .foregroundStyle(.white)
                    }
                }
                
                DynamicIslandExpandedRegion(.center) {
                    Text(timerInterval: Date()...context.state.endTime, showsHours: true)
                        .font(.system(.title2, design: .rounded, weight: .semibold))
                        .monospacedDigit()
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                }
                
                DynamicIslandExpandedRegion(.bottom) {
                    Text(context.attributes.stepDescription)
                        .font(.caption)
                        .foregroundStyle(.white.opacity(0.8))
                        .lineLimit(2)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.top, 2)
                }
            } compactLeading: {
                Label {
                    Text(timerInterval: Date()...context.state.endTime, showsHours: true)
                        .monospacedDigit()
                        .foregroundStyle(.white)
                        .font(.caption2)
                } icon: {
                    Image(systemName: "timer")
                        .foregroundStyle(.white)
                }
            } compactTrailing: {
                Text("Step \(context.state.stepNumber)")
                    .font(.caption2)
                    .foregroundStyle(.white)
            } minimal: {
                Image(systemName: "timer")
                    .foregroundStyle(.white)
            }
        }
    }
}

// Lock screen/Notification Center view
struct LockScreenLiveActivityView: View {
    let context: ActivityViewContext<RecipeTimerAttributes>
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.black.opacity(0.8))
            
            VStack(alignment: .center, spacing: 12) {
                HStack {
                    Label {
                        Text(context.state.recipeName)
                            .font(.headline)
                            .foregroundStyle(.white)
                    } icon: {
                        Image(systemName: "fork.knife")
                            .foregroundStyle(.white)
                    }
                    
                    Spacer()
                    
                    Label("Step \(context.state.stepNumber)", systemImage: "list.number")
                        .font(.subheadline)
                        .foregroundStyle(.white)
                }
                
                Text(timerInterval: Date()...context.state.endTime, showsHours: true)
                    .font(.system(.largeTitle, design: .rounded, weight: .bold))
                    .monospacedDigit()
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                
                Text(context.attributes.stepDescription)
                    .font(.callout)
                    .foregroundStyle(.white.opacity(0.8))
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                    .frame(maxWidth: .infinity)
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
