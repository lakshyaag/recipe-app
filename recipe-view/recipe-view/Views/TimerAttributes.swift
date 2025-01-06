import ActivityKit

struct TimerAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        var remainingTime: Int
    }
    
    var name: String
}
