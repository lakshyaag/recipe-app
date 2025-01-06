//
//  UIColor+Extensions.swift
//  recipe-view
//
//  Created by Lakshya Agarwal on 2025-01-05.
//

import UIKit

extension UIColor {
	// Primary brand color - Warm Orange
	static var customLightest: UIColor {
		UIColor { traitCollection in
			switch traitCollection.userInterfaceStyle {
			case .dark:
				return UIColor(hex: "#FFB05C") // Light warm orange for dark mode
			default:
				return UIColor(hex: "#FFAA47") // Bright warm orange for light mode
			}
		}
	}

	static var customLight: UIColor {
		UIColor { traitCollection in
			switch traitCollection.userInterfaceStyle {
			case .dark:
				return UIColor(hex: "#FFA033") // Bright orange for dark mode
			default:
				return UIColor(hex: "#FF9826") // Medium warm orange for light mode
			}
		}
	}

	static var customBase: UIColor {
		UIColor { traitCollection in
			switch traitCollection.userInterfaceStyle {
			case .dark:
				return UIColor(hex: "#FF9826") // Base orange for dark mode
			default:
				return UIColor(hex: "#FF8F1F") // Our target orange for light mode
			}
		}
	}

	static var customDark: UIColor {
		UIColor { traitCollection in
			switch traitCollection.userInterfaceStyle {
			case .dark:
				return UIColor(hex: "#FF8F1F") // Our target orange for dark mode
			default:
				return UIColor(hex: "#F27D0C") // Deep orange for light mode
			}
		}
	}

	static var customDarkest: UIColor {
		UIColor { traitCollection in
			switch traitCollection.userInterfaceStyle {
			case .dark:
				return UIColor(hex: "#F27D0C") // Deep orange for dark mode
			default:
				return UIColor(hex: "#D66F0A") // Darkest orange for light mode
			}
		}
	}

	// Action colors - Blue tints for interactive elements (keeping blue for non-brand actions)
	static var actionBase: UIColor {
		UIColor { traitCollection in
			switch traitCollection.userInterfaceStyle {
			case .dark:
				return UIColor(hex: "#60A5FA") // Bright blue for dark mode
			default:
				return UIColor(hex: "#3B82F6") // Standard blue for light mode
			}
		}
	}
}

extension UIColor {
	convenience init(hex: String) {
		let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
		var int = UInt64()
		Scanner(string: hex).scanHexInt64(&int)
		let a, r, g, b: UInt64
		switch hex.count {
		case 3: // RGB (12-bit)
			(a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
		case 6: // RGB (24-bit)
			(a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
		case 8: // ARGB (32-bit)
			(a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
		default:
			(a, r, g, b) = (255, 0, 0, 0)
		}
		self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
	}
}
