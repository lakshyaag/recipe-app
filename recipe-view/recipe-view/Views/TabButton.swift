//
//  TabButton.swift
//  recipe-view
//
//  Created by Lakshya Agarwal on 2025-01-05.
//

import SwiftUI

// Custom Tab Button
struct TabButton: View {
	let title: String
	let isSelected: Bool
	let action: () -> Void

	var body: some View {
		Button(action: action) {
			VStack(spacing: 4) {
				Text(title)
					.font(.headline)
					.foregroundColor(isSelected ? AppColors.primary : .secondary)
				
				if isSelected {
					Rectangle()
						.frame(height: 2)
						.foregroundColor(AppColors.primary)
				}
			}
			.frame(maxWidth: .infinity)
		}
	}
}
