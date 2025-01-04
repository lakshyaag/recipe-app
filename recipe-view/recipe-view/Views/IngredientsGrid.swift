//
//  IngredientsGrid.swift
//  recipe-view
//
//  Created by Lakshya Agarwal on 2025-01-04.
//

import SwiftUI

struct IngredientsGridView: View {
	let ingredients: [String]
	private let columns = Array(repeating: GridItem(.flexible()), count: 3)
	
	var body: some View {
		LazyVGrid(columns: columns, spacing: 12) {
			ForEach(ingredients, id: \.self) { item in
				Text(item)
					.font(.body)
					.padding(4)
					.background(Color(uiColor: .systemFill))
					.cornerRadius(8)
			}
		}
	}
}
