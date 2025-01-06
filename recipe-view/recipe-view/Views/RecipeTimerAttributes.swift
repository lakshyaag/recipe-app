import ActivityKit
import Foundation

public struct RecipeTimerAttributes: ActivityAttributes {
	public struct ContentState: Codable, Hashable {
		public var endTime: Date
		public var stepNumber: Int
		public var recipeName: String
		
		public init(endTime: Date, stepNumber: Int, recipeName: String) {
			self.endTime = endTime
			self.stepNumber = stepNumber
			self.recipeName = recipeName
		}
	}
	
	public var stepDescription: String
	public var timeAmount: Double
	public var timeUnit: String
	
	public init(stepDescription: String, timeAmount: Double, timeUnit: String) {
		self.stepDescription = stepDescription
		self.timeAmount = timeAmount
		self.timeUnit = timeUnit
	}
}
