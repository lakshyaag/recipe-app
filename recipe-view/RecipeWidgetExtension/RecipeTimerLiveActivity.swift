import WidgetKit
import SwiftUI
import ActivityKit

struct RecipeTimerLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: RecipeTimerAttributes.self) { context in
            // Lock screen/banner UI
            LockScreenLiveActivityView(context: context)
        } dynamicIsland: { context in
            // Dynamic Island
            DynamicIsland {
                // Expanded UI
                DynamicIslandExpandedRegion(.leading) {
                    Label {
                        Text(context.state.recipeName)
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    } icon: {
                        Image(systemName: "fork.knife")
                            .foregroundStyle(.indigo)
                    }
                }
                
                DynamicIslandExpandedRegion(.trailing) {
                    Label {
                        Text("Step \(context.state.stepNumber)")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    } icon: {
                        Image(systemName: "list.number")
                            .foregroundStyle(.indigo)
                    }
                }
                
                DynamicIslandExpandedRegion(.center) {
                    Text(timerInterval: Date()...context.state.endTime, showsHours: true)
                        .font(.system(.title2, design: .rounded, weight: .semibold))
                        .monospacedDigit()
                        .foregroundStyle(.primary)
                }
                
                DynamicIslandExpandedRegion(.bottom) {
                    Text(context.attributes.stepDescription)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .lineLimit(2)
                }
            } compactLeading: {
                Label {
                    Text(timerInterval: Date()...context.state.endTime, showsHours: true)
                        .monospacedDigit()
                        .foregroundStyle(.primary)
                } icon: {
                    Image(systemName: "timer")
                        .foregroundStyle(.indigo)
                }
            } compactTrailing: {
                Text("Step \(context.state.stepNumber)")
                    .font(.caption2)
                    .foregroundStyle(.secondary)
            } minimal: {
                Image(systemName: "timer")
                    .foregroundStyle(.indigo)
            }
        }
    }
}

// Lock screen/Notification Center view
struct LockScreenLiveActivityView: View {
    let context: ActivityViewContext<RecipeTimerAttributes>
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(systemName: "fork.knife")
                    .foregroundStyle(.indigo)
                Text(context.state.recipeName)
                    .font(.headline)
                Spacer()
                Label("Step \(context.state.stepNumber)", systemImage: "list.number")
                    .font(.subheadline)
            }
            
            Text(timerInterval: Date()...context.state.endTime, showsHours: true)
                .font(.system(.largeTitle, design: .rounded, weight: .bold))
                .monospacedDigit()
                .frame(maxWidth: .infinity)
            
            Text(context.attributes.stepDescription)
                .font(.caption)
                .foregroundStyle(.secondary)
                .lineLimit(2)
        }
        .padding()
    }
}

