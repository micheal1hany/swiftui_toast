//
//  View+Toast.swift
//
//  Created by Micheal Hany on 12/18/23.
//

import SwiftUI

/// Extension to add a toast to any View.
public extension View {
    /// Shows a toast with a provided configuration.
    ///
    /// - Parameters:
    ///   - toast: A binding to the toast to display.
    ///   - edge: The edge of the screen where the toast appears (`.top` or `.bottom`).
    ///   - toastLength: The duration the toast is displayed (`.short`, `.long`, or custom).
    ///   - autoDismissible: Whether the toast should automatically dismiss after the duration.
    ///   - onDismiss: A closure called when the toast is dismissed.
    ///   - backgroundColor: Optional color to use as the toast's background.
    ///   - textColor: Optional color for the toast's message text.
    ///   - trailingView: A closure returning a custom trailing view to display (e.g., button, icon).
    ///   - messageView: A closure returning a custom view for the toast's message (overrides default text).
    ///   - backgroundView: A closure returning a custom background view for the toast (e.g., gradient, image).
    func toast<TrailingView: View,MessageView: View,BackgroundView:View>(
        _ toast: Binding<Toast?>,
        edge: ToastEdge = .top,
        toastLength: ToastLength = .short,
        autoDismissible: Bool = true,
        onDismiss: @escaping () -> Void = {},
        backgroundColor: Color? = nil,
        textColor: Color? = nil,
        @ViewBuilder trailingView: () -> TrailingView = { EmptyView() },
        @ViewBuilder messageView: () -> MessageView = { EmptyView() },
        @ViewBuilder backgroundView: () -> BackgroundView = { EmptyView() }
    ) -> some View {
        modifier(
            ToastModifier(
                toast: toast,
                backgroundColor: backgroundColor,
                textColor: textColor,
                edge: edge,
                isAutoDismissed: autoDismissible,
                toastLength: toastLength,
                onDismiss: onDismiss,
                trailingView: trailingView(),
                messageView: messageView(),
                backgroundView: backgroundView()
            )
        )
    }
}
