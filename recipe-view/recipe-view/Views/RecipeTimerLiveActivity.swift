import SwiftUI
import ActivityKit
import WidgetKit

struct RecipeTimerLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: RecipeTimerAttributes.self) { context in
            RecipeTimerActivityView(context: context)
        } dynamicIsland: { context in
            DynamicIsland {
                DynamicIslandExpandedRegion(.leading) {
                    Label {
                        Text(context.state.recipeName)
                            .font(.caption)
                            .foregroundColor(.secondary)
                    } icon: {
                        Image(systemName: "fork.knife")
                            .foregroundStyle(.indigo)
                    }
                }
                
                DynamicIslandExpandedRegion(.trailing) {
                    Label {
                        Text("Step \(context.state.stepNumber)")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    } icon: {
                        Image(systemName: "list.number")
                            .foregroundStyle(.indigo)
                    }
                }
                
                DynamicIslandExpandedRegion(.center) {
                    Text(timerInterval: Date()...context.state.endTime, showsHours: true)
                        .font(.system(.title2, design: .rounded, weight: .semibold))
                        .foregroundColor(.primary)
                        .monospacedDigit()
                }
                
                DynamicIslandExpandedRegion(.bottom) {
                    Text(context.attributes.stepDescription)
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .lineLimit(2)
                }
            } compactLeading: {
                Label {
                    Text(timerInterval: Date()...context.state.endTime, showsHours: true)
                        .monospacedDigit()
                } icon: {
                    Image(systemName: "timer")
                        .foregroundStyle(.indigo)
                }
            } compactTrailing: {
                Text("Step \(context.state.stepNumber)")
                    .font(.caption2)
            } minimal: {
                Image(systemName: "timer")
                    .foregroundStyle(.indigo)
            }
        }
    }
}

struct RecipeTimerActivityView: View {
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
                .foregroundColor(.primary)
                .monospacedDigit()
                .frame(maxWidth: .infinity)
            
            Text(context.attributes.stepDescription)
                .font(.caption)
                .foregroundColor(.secondary)
                .lineLimit(2)
        }
        .padding()
    }
} 