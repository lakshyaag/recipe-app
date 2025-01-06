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
				UNUserNotificationCenter.current().delegate = self
			} else if let error = error {
				print("Error requesting notification permission: \(error.localizedDescription)")
			}
		}
		return true
	}
}

extension AppDelegate: UNUserNotificationCenterDelegate {
	func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
		print("Notification received with identifier \(notification.request.identifier)")
		// So we call the completionHandler telling that the notification should display a banner and play the notification sound - this will happen while the app is in foreground
		completionHandler([.banner, .sound])
	}
}
