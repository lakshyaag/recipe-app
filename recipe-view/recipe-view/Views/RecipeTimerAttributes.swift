import ActivityKit
import Foundation

struct RecipeTimerAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        var endTime: Date
        var stepNumber: Int
        var recipeName: String
    }
    
    var stepDescription: String
    var timeAmount: Double
    var timeUnit: String
} 

