//
//  Toast.swift
//
//  Created by Micheal Hany on 12/17/23.
//

import SwiftUI

public struct Toast {
    public let icon: Image
    public let color: Color
    public let message: String

    public init(
        icon: Image,
        color: Color,
        message: String
    ) {
        self.icon = icon
        self.color = color
        self.message = message
    }
}

extension Toast: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(color)
        hasher.combine(message)
    }
}

/// Extension to the Toast struct to provide convenience initializers for different types of toasts.
extension Toast {
    /// Creates a debug toast with a purple color and a debug icon.
    public static func debug(message: String) -> Toast {
        .init(icon: Image(.debug), color: .purple, message: message)
    }
    
    /// Creates an error toast with a red color and an error icon.
    public static func error(message: String) -> Toast {
        .init(icon: Image(.error), color: .red, message: message)
    }
    
    /// Creates an info toast with a blue color and an info icon.
    public static func info(message: String) -> Toast {
        .init(icon: Image(.info), color: .blue, message: message)
    }
    
    /// Creates a notice toast with an orange color and a notice icon.
    public static func notice(message: String) -> Toast {
        .init(icon: Image(.notice), color: .orange, message: message)
    }
    
    /// Creates a success toast with a green color and a success icon.
    public static func success(message: String) -> Toast {
        .init(icon: Image(.success), color: .green, message: message)
    }
    
    /// Creates a warning toast with a yellow color and a warning icon.
    public static func warning(message: String) -> Toast {
        .init(icon: Image(.warning), color: .yellow, message: message)
    }
}

public enum ToastLength:Double{
    case short = 3
    case long = 5
}

public enum ToastEdge {
    case top
    case bottom

    var alignment: Alignment {
        switch self {
        case .top: return .top
        case .bottom: return .bottom
        }
    }
}
