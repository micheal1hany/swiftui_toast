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
    public let bundle: Bundle?

    public init(
        icon: Image,
        color: Color,
        message: String,
        bundle: Bundle? = .main
    ) {
        self.icon = icon
        self.color = color
        self.message = message
        self.bundle = bundle
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
    public static func debug(message: String,bundle: Bundle? = .main) -> Toast {
        .init(icon: Image(.debug), color: .purple, message: message,bundle: bundle)
    }
    
    /// Creates an error toast with a red color and an error icon.
    public static func error(message: String,bundle: Bundle? = .main) -> Toast {
        .init(icon: Image(.error), color: .red, message: message,bundle: bundle)
    }
    
    /// Creates an info toast with a blue color and an info icon.
    public static func info(message: String,bundle: Bundle? = .main) -> Toast {
        .init(icon: Image(.info), color: .blue, message: message,bundle: bundle)
    }
    
    /// Creates a notice toast with an orange color and a notice icon.
    public static func notice(message: String,bundle: Bundle? = .main) -> Toast {
        .init(icon: Image(.notice), color: .orange, message: message,bundle: bundle)
    }
    
    /// Creates a success toast with a green color and a success icon.
    public static func success(message: String,bundle: Bundle? = .main) -> Toast {
        .init(icon: Image(.success), color: .green, message: message,bundle: bundle)
    }
    
    /// Creates a warning toast with a yellow color and a warning icon.
    public static func warning(message: String,bundle: Bundle? = .main) -> Toast {
        .init(icon: Image(.warning), color: .yellow, message: message,bundle: bundle)
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
