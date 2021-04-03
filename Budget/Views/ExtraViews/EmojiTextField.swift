//
//  EmojiTextField.swift
//  Budget
//
//  Created by Nicolas Machado on 4/2/21.
//

import SwiftUI

class EmojiTextFieldUIKit: UITextField {

   // required for iOS 13
   override var textInputContextIdentifier: String? { "" } // return non-nil to show the Emoji keyboard ¯\_(ツ)_/¯

    override var textInputMode: UITextInputMode? {
        for mode in UITextInputMode.activeInputModes {
            if mode.primaryLanguage == "emoji" {
                return mode
            }
        }
        return nil
    }
}

struct EmojiTextField: UIViewRepresentable {
    @Binding public var isFirstResponder: Bool
    @Binding public var text: String

    public var configuration = { (view: EmojiTextFieldUIKit) in }

    public init(text: Binding<String>, isFirstResponder: Binding<Bool>, configuration: @escaping (EmojiTextFieldUIKit) -> () = { _ in }) {
        self.configuration = configuration
        self._text = text
        self._isFirstResponder = isFirstResponder
    }

    public func makeUIView(context: Context) -> EmojiTextFieldUIKit {
        let view = EmojiTextFieldUIKit()
        
        //clear cursor and text. SO hacky ahhhh
        view.tintColor = .clear
        view.textColor = .clear
        
        view.addTarget(context.coordinator, action: #selector(Coordinator.textViewDidChange), for: .editingChanged)
        view.delegate = context.coordinator
        return view
    }

    public func updateUIView(_ uiView: EmojiTextFieldUIKit, context: Context) {
        uiView.text = text
        switch isFirstResponder {
        case true: uiView.becomeFirstResponder()
        case false: uiView.resignFirstResponder()
        }
    }

    public func makeCoordinator() -> Coordinator {
        Coordinator($text, isFirstResponder: $isFirstResponder)
    }

    public class Coordinator: NSObject, UITextFieldDelegate {
        var text: Binding<String>
        var isFirstResponder: Binding<Bool>

        init(_ text: Binding<String>, isFirstResponder: Binding<Bool>) {
            self.text = text
            self.isFirstResponder = isFirstResponder
        }

        @objc public func textViewDidChange(_ textField: EmojiTextFieldUIKit) {
            self.text.wrappedValue = textField.text ?? ""
        }

        public func textFieldDidBeginEditing(_ textField: EmojiTextFieldUIKit) {
            self.isFirstResponder.wrappedValue = true
        }

        public func textFieldDidEndEditing(_ textField: EmojiTextFieldUIKit) {
            self.isFirstResponder.wrappedValue = false
        }
    }
}

