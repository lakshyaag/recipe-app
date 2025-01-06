//
//  RecipeTimerWidgetBundleBundle.swift
//  RecipeTimerWidgetBundle
//
//  Created by Lakshya Agarwal on 2025-01-05.
//

import WidgetKit
import SwiftUI

@main
struct RecipeTimerWidgetBundleBundle: WidgetBundle {
    var body: some Widget {
        RecipeTimerWidgetBundle()
        RecipeTimerWidgetBundleControl()
        RecipeTimerWidgetBundleLiveActivity()
    }
}
