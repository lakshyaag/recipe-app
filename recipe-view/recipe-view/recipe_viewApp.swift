//
//  recipe_viewApp.swift
//  recipe-view
//
//  Created by Lakshya Agarwal on 2025-01-04.
//

import SwiftUI
import UserNotifications

@main
struct RecipeViewApp: App {
	@UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
	
	var body: some Scene {
		WindowGroup {
			ContentView()
		}
	}
}

class AppDelegate: NSObject, UIApplicationDelegate {
	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
		// Request notification permissions
		UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
			if granted {
				print("Notification permission granted")
			} else if let error = error {
				print("Error requesting notification permission: \(error.localizedDescription)")
			}
		}
		return true
	}
}
