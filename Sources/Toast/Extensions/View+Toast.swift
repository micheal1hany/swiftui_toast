//
//  View+Toast.swift
//
//  Created by Micheal Hany on 12/18/23.
//

import SwiftUI

/// Extension to add a toast to any View.
public extension View {
    /// Shows a toast with a provided configuration.
    /// - Parameters:
    ///   - toast: A binding to the toast to display.
    ///   - edge: The edge of the screen where the toast appears.
    ///   - autoDismissable: Whether the toast should automatically dismiss.
    ///   - onDismiss: A closure to call when the toast is dismissed.
    ///   - trailingView: A closure that returns a trailing view to be displayed in the toast.
    func toast<TrailingView: View>(
        _ toast: Binding<Toast?>,
        edge: ToastEdge = .top,
        toastLength: ToastLength = .short,
        autoDismissible: Bool = true,
        onDismiss: @escaping () -> Void = {},
        @ViewBuilder trailingView: @escaping () -> TrailingView = { EmptyView() }
    ) -> some View {
        modifier(
            ToastModifier(
                toast: toast,
                edge: edge,
                isAutoDismissed: autoDismissible,
                toastLength: toastLength,
                onDismiss: onDismiss,
                trailingView: trailingView()
            )
        )
    }
}
