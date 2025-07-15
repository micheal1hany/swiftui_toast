//
//  ToastModifier.swift
//
//  Created by Micheal Hany on 1/5/25.
//

import SwiftUI

@MainActor
struct ToastModifier<TrailingView: View,MessageView: View,BackgroundView:View>: ViewModifier {
    private let edge: ToastEdge
    private let offset: CGFloat
    private let isAutoDismissed: Bool
    private var toastLength: ToastLength
    private let onDismiss: () -> Void
    private let backgroundColor: Color?
    private let textColor: Color?
    private let trailingView: TrailingView
    private let messageView: MessageView
    private let backgroundView: BackgroundView
    @Binding private var toast: Toast?
    @State private var isPresented: Bool = false

    private var yOffset: CGFloat {
        isPresented ? .zero : offset
    }

    init(
        toast: Binding<Toast?>,
        backgroundColor: Color? = nil,
        textColor: Color? = nil,
        edge: ToastEdge,
        isAutoDismissed: Bool,
        toastLength: ToastLength,
        onDismiss: @escaping () -> Void,
        trailingView: TrailingView,
        messageView: MessageView,
        backgroundView: BackgroundView
    ) {
        self._toast = toast
        self.backgroundColor = backgroundColor
        self.textColor = textColor
        self.edge = edge
        self.isAutoDismissed = isAutoDismissed
        self.toastLength = toastLength
        self.trailingView = trailingView
        self.messageView = messageView
        self.backgroundView = backgroundView
        self.onDismiss = onDismiss
        self.offset = edge == .top ? -200 : 200
    }

    private func onChangeDragGesture(_ value: DragGesture.Value) {
        dismissToastAnimation()
    }

    private func onChangeToast(_ oldToast: Toast?, _ newToast: Toast?) {
        if newToast != nil {
            presentToastAnimation()
        }
    }

    private func presentToastAnimation() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            withAnimation(.spring()) {
                isPresented = true
            }
        }
        if isAutoDismissed {
            autoDismissToastAnimation()
        }
    }

    private func dismissToastAnimation() {
        withAnimation(.easeOut(duration: 0.8)) {
            isPresented = false
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
            toast = nil
            onDismiss()
        }
    }

    private func autoDismissToastAnimation() {
        DispatchQueue.main.asyncAfter(deadline: .now() + toastLength.rawValue) {
            dismissToastAnimation()
        }
    }

    func body(content: Content) -> some View {
        content
            .onChange(of: toast) { newValue in
                onChangeToast(nil, newValue)
            }
            .overlay(toastView(), alignment: edge.alignment)
    }

    @ViewBuilder
    private func toastView() -> some View {
        if let toast {
            ToastMessageView(toast,backgroundColor: backgroundColor,textColor: textColor, trailingView: { trailingView },messageView: {messageView}, backgroundView: {backgroundView})
                .offset(y: yOffset)
                .gesture(dragGesture)
        }
    }

    private var dragGesture: some Gesture {
        DragGesture(minimumDistance: .zero)
            .onChanged(onChangeDragGesture)
    }
}
