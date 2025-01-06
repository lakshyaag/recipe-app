import SwiftUI
import UIKit

enum AppColors {
    // MARK: - Brand Colors
    static let brandLightest = Color(uiColor: .customLightest)
    static let brandLight = Color(uiColor: .customLight)
    static let brandBase = Color(uiColor: .customBase)
    static let brandDark = Color(uiColor: .customDark)
    static let brandDarkest = Color(uiColor: .customDarkest)
    
    // MARK: - Recipe App Specific
    static let recipeCard = Color(uiColor: .systemBackground)
    static let recipeCardShadow = Color.black.opacity(0.05)
    static let timeLabel = Color(uiColor: .secondaryLabel)
    static let searchBackground = Color(uiColor: .secondarySystemBackground)
    static let tabBarSelected = brandBase
    static let tabBarUnselected = Color(uiColor: .tertiaryLabel)
    
    // MARK: - Action Colors
    static let actionPrimary = brandBase // Using orange for primary actions
    static let actionSecondary = Color(uiColor: .secondarySystemFill)
    static let startButton = brandBase
    static let scaleButton = brandBase.opacity(0.15)
    static let filterButton = brandBase.opacity(0.1)
    
    // MARK: - Recipe Element Colors
    static let servingsIcon = brandBase
    static let timeIcon = brandBase
    static let difficultyIcon = brandBase
    static let ingredientIcon = brandBase
    
    // MARK: - Background Colors
    static let backgroundPrimary = Color(uiColor: .systemBackground)
    static let backgroundSecondary = Color(uiColor: .secondarySystemBackground)
    static let backgroundTertiary = Color(uiColor: .tertiarySystemBackground)
    static let groupedBackground = Color(uiColor: .systemGroupedBackground)
    static let groupedBackgroundSecondary = Color(uiColor: .secondarySystemGroupedBackground)
    
    // MARK: - Content Colors
    static let contentPrimary = Color(uiColor: .label)
    static let contentSecondary = Color(uiColor: .secondaryLabel)
    static let contentTertiary = Color(uiColor: .tertiaryLabel)
    static let contentDisabled = Color(uiColor: .quaternaryLabel)
    
    // MARK: - Separator Colors
    static let separatorPrimary = Color(uiColor: .separator)
    static let separatorOpaque = Color(uiColor: .opaqueSeparator)
    
    // MARK: - Utility Colors
    static let overlay = Color.black.opacity(0.4)
    static let shadow = Color.black.opacity(0.1)
    
    // MARK: - Status Colors
    static let success = Color(uiColor: .systemGreen)
    static let warning = Color(uiColor: .systemYellow)
    static let error = Color(uiColor: .systemRed)
    static let info = Color(uiColor: .systemBlue)
    
    // MARK: - Interactive States
    static func brandColor(for state: UIControl.State) -> Color {
        switch state {
        case .normal:
            return brandBase
        case .highlighted:
            return brandDark
        case .disabled:
            return brandLightest.opacity(0.5)
        case .selected:
            return brandDarkest
        default:
            return brandBase
        }
    }
    
    // MARK: - Recipe Button States
    static func actionButton(for state: UIControl.State) -> Color {
        switch state {
        case .normal:
            return actionPrimary
        case .highlighted:
            return brandDark
        case .disabled:
            return contentDisabled
        default:
            return actionPrimary
        }
    }
    
    // MARK: - Gradients
    static let brandGradient = LinearGradient(
        colors: [brandLight, brandBase],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
    
    static let actionGradient = LinearGradient(
        colors: [brandBase, brandDark],
        startPoint: .leading,
        endPoint: .trailing
    )
}

// MARK: - Color Scheme Extensions
extension View {
    func adaptiveBackgroundColor(_ light: Color, dark: Color) -> some View {
        self.background(Color.adaptiveColor(light: light, dark: dark))
    }
}

extension Color {
    static func adaptiveColor(light: Color, dark: Color) -> Color {
        Color(uiColor: UIColor { traitCollection in
            switch traitCollection.userInterfaceStyle {
            case .light:
                return UIColor(light)
            case .dark:
                return UIColor(dark)
            case .unspecified:
                return UIColor(light)
            @unknown default:
                return UIColor(light)
            }
        })
    }
}
