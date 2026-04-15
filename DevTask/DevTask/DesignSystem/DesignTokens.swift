import SwiftUI

enum DesignTokens {

    // MARK: - Primary

    static let primary: Color = .indigo

    // MARK: - Secondary

    static let secondary: Color = .purple

    // MARK: - Surface

    static let onSurface: Color = Color(uiColor: .label)
    static let onSurfaceVariant: Color = Color(uiColor: .secondaryLabel)

    // MARK: - Background

    static let backgroundGradient = LinearGradient(
        colors: [
            primary.opacity(0.6),
            primary.opacity(0.4),
            secondary.opacity(0.5)
        ],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )

}
