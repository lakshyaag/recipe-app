//
//  ContentView.swift
//  recipe-view
//
//  Created by Lakshya Agarwal on 2025-01-04.
//

import SwiftUI

struct ContentView: View {
	@StateObject private var viewModel = RecipeViewModel()
	@State private var selectedTab: Tab = .ingredients // Track the selected tab

	enum Tab {
		case ingredients
		case instructions
	}

	var body: some View {
		NavigationView {
			ScrollView {
				VStack(spacing: 24) {
					// URL Input Card
					VStack(spacing: 20) {
						VStack(alignment: .leading, spacing: 8) {
							Label("Recipe URL", systemImage: "link")
								.font(.headline)
								.foregroundColor(AppColors.text)

							HStack(spacing: 12) {
								TextField("Paste recipe URL", text: $viewModel.url)
									.textFieldStyle(.plain)
									.font(.body)
									.autocapitalization(.none)
									.disableAutocorrection(true)
									.textInputAutocapitalization(.never)
									.padding(16)
									.background(
										RoundedRectangle(cornerRadius: 12)
											.fill(Color(.systemGray6))
									)
									.overlay(
										RoundedRectangle(cornerRadius: 12)
											.stroke(Color(.systemGray4), lineWidth: 1)
									)

								Button(action: {
									// Dismiss keyboard
									UIApplication.shared.sendAction(
										#selector(UIResponder.resignFirstResponder),
										to: nil,
										from: nil,
										for: nil)
									if let string = UIPasteboard.general.string {
										viewModel.url = string
									}
								}) {
									Image(systemName: "doc.on.clipboard")
										.font(.system(size: 16, weight: .medium))
										.foregroundColor(.white)
										.frame(width: 44, height: 44)
										.background(AppColors.primary)
										.clipShape(Circle())
								}
							}
						}

						Button(action: { viewModel.fetchRecipe() }) {
							HStack(spacing: 8) {
								if viewModel.isLoading {
									ProgressView()
										.progressViewStyle(.circular)
										.tint(.white)
								} else {
									Image(systemName: "wand.and.stars")
								}
								Text(viewModel.isLoading ? "Processing..." : "Get Recipe")
							}
							.font(.headline)
							.foregroundColor(.white)
							.frame(maxWidth: .infinity)
							.frame(height: 50)
							.background {
								RoundedRectangle(cornerRadius: 12, style: .continuous)
									.fill(
										LinearGradient(
											colors: [AppColors.primary, AppColors.secondary],
											startPoint: .leading,
											endPoint: .trailing
										)
									)
							}
							.opacity(viewModel.url.isEmpty ? 0.6 : 1.0)
						}
						.disabled(viewModel.url.isEmpty || viewModel.isLoading)
					}
					.padding(20)
					.background(AppColors.cardBackground)
					.cornerRadius(16)
					.shadow(color: Color.black.opacity(0.05), radius: 8, x: 0, y: 2)

					// Recipe Display
					if let currentRecipe = viewModel.recipe {
						VStack(spacing: 16) {
							// Tab Bar
							HStack {
								TabButton(title: "Ingredients", isSelected: selectedTab == .ingredients) {
									selectedTab = .ingredients
								}
								TabButton(title: "Instructions", isSelected: selectedTab == .instructions) {
									selectedTab = .instructions
								}
							}
							.padding(.horizontal, 16)

							// Tab Content
							switch selectedTab {
							case .ingredients:
								IngredientsSection(ingredients: currentRecipe.ingredients)
							case .instructions:
								InstructionsSection(instructions: currentRecipe.instructions)
							}
						}
						.transition(
							.asymmetric(
								insertion: .scale.combined(with: .opacity),
								removal: .opacity
							))
					}
				}
				.padding(.horizontal)
				.padding(.vertical, 24)
			}
			.navigationTitle("Recipe Viewer")
			.background(AppColors.background.ignoresSafeArea())
			.toolbar {
				ToolbarItem(placement: .navigationBarTrailing) {
					Button(action: { viewModel.resetForm() }) {
						Label("Reset", systemImage: "arrow.clockwise")
							.labelStyle(.iconOnly)
							.foregroundColor(AppColors.primary)
					}
					.disabled(viewModel.isLoading)
				}
			}
			.animation(.spring(response: 0.3, dampingFraction: 0.8), value: viewModel.recipe != nil)
		}
	}
}


#Preview {
    ContentView()
}
