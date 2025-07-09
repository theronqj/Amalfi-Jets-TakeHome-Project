//
//  ViewExtensions.swift
//  AmalfiJetsTakeHome
//
//  Created by Theron on 7/8/25.
//

import SwiftUI

// MARK: - Custom Corner Radius Modifier

/// Custom view modifiers for the Amalfi Jets app.
extension View {
    /// Applies a corner radius to specified corners of a view.
    ///
    /// - Parameters:
    ///   - radius: The radius of the corners.
    ///   - corners: The corners to apply the radius to.
    /// - Returns: A view with the specified corners rounded.
    func ajCornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(AJRoundedCorner(radius: radius, corners: corners))
    }
}

/// A custom `Shape` for rounding specified corners of a rectangle.
struct AJRoundedCorner: Shape {
    /// The corner radius.
    var radius: CGFloat = .infinity
    /// The corners to round.
    var corners: UIRectCorner = .allCorners

    /// Creates a path with the specified rounded corners.
    /// - Parameter rect: The rectangle to apply the rounded corners to.
    /// - Returns: A `Path` with the specified corners rounded.
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
