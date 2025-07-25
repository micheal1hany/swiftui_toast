//
//  ToastMessageView.swift
//
//  Created by Micheal Hany on 12/17/23.
//

import SwiftUI

struct ToastMessageView<TrailingView: View,MessageView: View,BackgroundView:View>: View {
    private let toast: Toast
    private let backgroundColor: Color?
    private let textColor: Color?
    private let trailingView: TrailingView
    private let messageView: MessageView
    private let backgroundView: BackgroundView

    init(
        _ toast: Toast,
        backgroundColor: Color? = nil,
        textColor: Color? = nil,
        @ViewBuilder trailingView: () -> TrailingView = { EmptyView() },
        @ViewBuilder messageView: () -> MessageView = { EmptyView() },
        @ViewBuilder backgroundView: () -> BackgroundView = { EmptyView() }
    ) {
        self.toast = toast
        self.backgroundColor = backgroundColor
        self.textColor = textColor
        self.trailingView = trailingView()
        self.messageView = messageView()
        self.backgroundView = backgroundView()
    }

    var body: some View {
        HStack(spacing: 10) {
            toast.icon
                .font(.system(size: 24, weight: .medium))
                .foregroundColor(toast.color)

            if messageView is EmptyView {
                Text(LocalizedStringKey(toast.message),bundle: toast.bundle)
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(textColor ?? .primary)
            }else{
                messageView
            }
            

            Spacer(minLength: .zero)

            trailingView
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(resolvedBackgroundView)
        .padding()
    }

    @ViewBuilder
    private var resolvedBackgroundView: some View {
        if backgroundView is EmptyView{
            RoundedRectangle(cornerRadius: 10)
                .stroke(toast.color, lineWidth: 2)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(backgroundColor ?? toast.color.opacity(0.08))
                )
        }else{
            RoundedRectangle(cornerRadius: 10)
                .stroke(toast.color, lineWidth: 2)
                .background(backgroundView)
        }
        
    }
}

// MARK: Example Usages

extension ToastMessageView where TrailingView == EmptyView, MessageView == EmptyView , BackgroundView == EmptyView {
    static var infoExample: some View {
        ToastMessageView(.info(message: "Something informational for the user."))
    }

    static var successExample: some View {
        ToastMessageView(.success(message: "Successfully did the thing!"))
    }

    static var debugExample: some View {
        ToastMessageView(.debug(message: "Line 32 in `File.swift` executed."))
    }
}

struct NetworkErrorExample: View {
    var body: some View {
        ToastMessageView(.error(message: "Network Error!")) {
            ProgressView()
        }
    }
}

struct SomethingWrongExample: View {
    var body: some View {
        ToastMessageView(.warning(message: "Something went wrong!")) {
            Button(action:  {
                print("Go to logs")
            }) {
                Image(systemName: "doc.text.magnifyingglass")
            }
            .buttonStyle(.toastTrailing(tintColor: .yellow))
        }
    }
}

@MainActor
struct ExampleView {
    @State private var toastToPresent: Toast? = nil

    private func showAction() {
        toastToPresent = .notice(message: "A software update is available.")
    }

    private func updateAction() {
        print("Update Pressed")
    }
}

extension ExampleView: View {
    var body: some View {
        Button("Show Update Toast", action: showAction)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(40)
            .toast($toastToPresent, trailingView: updateButton)
    }

    @ViewBuilder
    private func updateButton() -> some View {
        if let toastToPresent {
            Button("Update", action: updateAction)
                .buttonStyle(
                    .toastTrailing(tintColor: toastToPresent.color)
                )
        }
    }
}

#Preview {
    VStack(spacing: 16) {
        ExampleView()
        ToastMessageView.infoExample
        ToastMessageView.successExample
        ToastMessageView.debugExample
        NetworkErrorExample()
        SomethingWrongExample()
    }
}
