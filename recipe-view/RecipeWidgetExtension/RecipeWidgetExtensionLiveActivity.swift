//
//  RecipeWidgetExtensionLiveActivity.swift
//  RecipeWidgetExtension
//
//  Created by Lakshya Agarwal on 2025-01-05.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct RecipeWidgetExtensionAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct RecipeWidgetExtensionLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: RecipeWidgetExtensionAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension RecipeWidgetExtensionAttributes {
    fileprivate static var preview: RecipeWidgetExtensionAttributes {
        RecipeWidgetExtensionAttributes(name: "World")
    }
}

extension RecipeWidgetExtensionAttributes.ContentState {
    fileprivate static var smiley: RecipeWidgetExtensionAttributes.ContentState {
        RecipeWidgetExtensionAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: RecipeWidgetExtensionAttributes.ContentState {
         RecipeWidgetExtensionAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: RecipeWidgetExtensionAttributes.preview) {
   RecipeWidgetExtensionLiveActivity()
} contentStates: {
    RecipeWidgetExtensionAttributes.ContentState.smiley
    RecipeWidgetExtensionAttributes.ContentState.starEyes
}
