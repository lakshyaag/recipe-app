//
//  SwipeInstructions.swift
//  recipe-view
//
//  Created by Lakshya Agarwal on 2025-01-04.
//

import SwiftUI

struct SwipeInstructionsView: View {
	let instructions: [String]

	var body: some View {
		TabView {
			ForEach(instructions.indices, id: \.self) { idx in
				Text(instructions[idx])
					.font(.body)
					.padding()
			}
		}
		.tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
	}
}
