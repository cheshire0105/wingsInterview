//
//  wingsInterviewWidgetLiveActivity.swift
//  wingsInterviewWidget
//
//  Created by cheshire on 1/10/24.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct wingsInterviewWidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct wingsInterviewWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: wingsInterviewWidgetAttributes.self) { context in
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

extension wingsInterviewWidgetAttributes {
    fileprivate static var preview: wingsInterviewWidgetAttributes {
        wingsInterviewWidgetAttributes(name: "World")
    }
}

extension wingsInterviewWidgetAttributes.ContentState {
    fileprivate static var smiley: wingsInterviewWidgetAttributes.ContentState {
        wingsInterviewWidgetAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: wingsInterviewWidgetAttributes.ContentState {
         wingsInterviewWidgetAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: wingsInterviewWidgetAttributes.preview) {
   wingsInterviewWidgetLiveActivity()
} contentStates: {
    wingsInterviewWidgetAttributes.ContentState.smiley
    wingsInterviewWidgetAttributes.ContentState.starEyes
}
