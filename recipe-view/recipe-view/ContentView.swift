//
//  ContentView.swift
//  recipe-view
//
//  Created by Lakshya Agarwal on 2025-01-04.
//

import SwiftUI
import UIKit

struct ContentView: View {
	@StateObject private var viewModel = RecipeViewModel()
	@State private var selectedTab: Tab = .ingredients

	enum Tab {
		case ingredients
		case instructions
	}

	var body: some View {
		NavigationView {
			mainContent
		}
	}

	private var mainContent: some View {
		ScrollView {
			VStack(spacing: 24) {
				urlInputCard
				recipeContent
			}
			.padding(.horizontal)
			.padding(.vertical, 24)
		}
		.navigationTitle("Recipe Viewer")
		.adaptiveBackgroundColor(AppColors.groupedBackground, dark: AppColors.backgroundSecondary)
		.toolbar { toolbarContent }
		.animation(.spring(response: 0.3, dampingFraction: 0.8), value: viewModel.recipe != nil)
		.alert("Error", isPresented: $viewModel.showError, presenting: viewModel.error) { _ in
			Button("OK", role: .cancel) {}
		} message: { error in
			Text(error.localizedDescription)
		}
	}

	private var urlInputCard: some View {
		VStack(spacing: 20) {
			urlInputField
			actionButton
		}
		.padding(20)
		.background(AppColors.groupedBackgroundSecondary)
		.cornerRadius(16)
		.shadow(color: AppColors.shadow, radius: 8, x: 0, y: 2)
	}

	private var urlInputField: some View {
		VStack(alignment: .leading, spacing: 8) {
			Label("Recipe URL", systemImage: "link")
				.font(.headline)
				.foregroundColor(AppColors.contentPrimary)

			HStack(spacing: 12) {
				textField
				pasteButton
			}

			errorMessage
		}
	}

	private var textField: some View {
		TextField("Paste recipe URL", text: $viewModel.url)
			.textFieldStyle(.plain)
			.font(.body)
			.autocapitalization(.none)
			.disableAutocorrection(true)
			.textInputAutocapitalization(.never)
			.padding(16)
			.background(
				RoundedRectangle(cornerRadius: 12)
					.fill(AppColors.backgroundSecondary)
			)
			.overlay(
				RoundedRectangle(cornerRadius: 12)
					.stroke(viewModel.error != nil ? AppColors.error : AppColors.separatorPrimary, lineWidth: 1)
			)
			.animation(.easeInOut(duration: 0.2), value: viewModel.error)
	}

	private var pasteButton: some View {
		Button(action: handlePaste) {
			Image(systemName: "doc.on.clipboard")
				.font(.system(size: 16, weight: .medium))
				.foregroundColor(AppColors.backgroundPrimary)
				.frame(width: 44, height: 44)
				.background(AppColors.actionPrimary)
				.clipShape(Circle())
		}
	}

	private var errorMessage: some View {
		Group {
			if let error = viewModel.error {
				Text(error.localizedDescription)
					.font(.caption)
					.foregroundColor(AppColors.error)
					.padding(.horizontal, 4)
					.transition(.opacity)
			}
		}
	}

	private var actionButton: some View {
		Button(action: { viewModel.fetchRecipe() }) {
			HStack(spacing: 8) {
				buttonIcon
				buttonText
			}
			.font(.headline)
			.foregroundColor(.white)
			.frame(maxWidth: .infinity)
			.frame(height: 50)
			.background(buttonBackground)
			.opacity(viewModel.url.isEmpty ? 0.6 : 1.0)
		}
		.disabled(viewModel.url.isEmpty || viewModel.isLoading)
	}

	private var buttonIcon: some View {
		Group {
			if viewModel.isLoading {
				ProgressView()
					.progressViewStyle(.circular)
					.tint(.white)
			} else {
				Image(systemName: "wand.and.stars")
			}
		}
	}

	private var buttonText: some View {
		Text(viewModel.isLoading ? "Processing..." : "Get Recipe")
	}

	private var buttonBackground: some View {
		RoundedRectangle(cornerRadius: 12, style: .continuous)
			.fill(
				LinearGradient(
					colors: [AppColors.brandBase,
							 AppColors.brandDark,
							],
					startPoint: .leading,
					endPoint: .trailing
				)
			)
	}

	private var recipeContent: some View {
		Group {
			if let currentRecipe = viewModel.recipe {
				VStack(spacing: 16) {
					tabPicker
					tabContent(recipe: currentRecipe)
				}
				.transition(
					.asymmetric(
						insertion: .scale.combined(with: .opacity),
						removal: .opacity
					))
			}
		}
	}

	private var tabPicker: some View {
		Picker("View", selection: $selectedTab) {
			Text("Ingredients").tag(Tab.ingredients)
			Text("Instructions").tag(Tab.instructions)
		}
		.pickerStyle(.segmented)
		.padding(.horizontal)
	}

	private func tabContent(recipe: Recipe) -> some View {
		Group {
			switch selectedTab {
			case .ingredients:
				IngredientsSection(ingredients: recipe.ingredients)
			case .instructions:
				InstructionsSection(instructions: recipe.instructions)
			}
		}
	}

	private var toolbarContent: some ToolbarContent {
		ToolbarItem(placement: .navigationBarTrailing) {
			Button(action: { viewModel.resetForm() }) {
				Label("Reset", systemImage: "arrow.clockwise")
					.labelStyle(.iconOnly)
					.foregroundColor(AppColors.actionPrimary)
			}
			.disabled(viewModel.isLoading)
		}
	}

	private func handlePaste() {
		// Dismiss keyboard
		UIApplication.shared.sendAction(
			#selector(UIResponder.resignFirstResponder),
			to: nil,
			from: nil,
			for: nil)
		if let string = UIPasteboard.general.string {
			viewModel.url = string
		}
	}
}

#Preview {
	ContentView()
}
