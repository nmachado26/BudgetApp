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
    
    @Binding public var emojiChosen: Bool
    
    public var configuration = { (view: EmojiTextFieldUIKit) in }
    
    public init(emojiChosen: Binding<Bool>, text: Binding<String>, isFirstResponder: Binding<Bool>, configuration: @escaping (EmojiTextFieldUIKit) -> () = { _ in }) {
        self.configuration = configuration
        self._text = text
        self._isFirstResponder = isFirstResponder
        self._emojiChosen = emojiChosen
    }
    
    public func makeUIView(context: Context) -> EmojiTextFieldUIKit {
        let view = EmojiTextFieldUIKit()
        
        //clear cursor and text. SO hacky ahhhh
        view.tintColor = .clear
        view.textColor = .black
        
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
        Coordinator($text, isFirstResponder: $isFirstResponder, emojiChosen: $emojiChosen)
    }
    
    public class Coordinator: NSObject, UITextFieldDelegate {
        var text: Binding<String>
        var isFirstResponder: Binding<Bool>
        
        var emojiChosen: Binding<Bool>
        
        init(_ text: Binding<String>, isFirstResponder: Binding<Bool>, emojiChosen: Binding<Bool>) {
            self.text = text
            self.isFirstResponder = isFirstResponder
            self.emojiChosen = emojiChosen
        }
        
        @objc public func textViewDidChange(_ textField: EmojiTextFieldUIKit) {
            if let finalChar = textField.text?.last {
                let str = String(finalChar)
                self.text.wrappedValue = str
                return
            }
            self.text.wrappedValue = ""
           
            //self.text.wrappedValue = textField.text?.last ?? ""
        }
        
//        public func textFieldDidBeginEditing(_ textField: UITextField) {
//            //textField.text = "" // shouldnt do this
//            self.isFirstResponder.wrappedValue = true
//
//        }
//        public func textFieldDidBeginEditing(_ textField: EmojiTextFieldUIKit) {
//            textField.text = ""
//            self.isFirstResponder.wrappedValue = true
//        }
        
        public func textFieldDidEndEditing(_ textField: EmojiTextFieldUIKit) {
            self.isFirstResponder.wrappedValue = false
        }
        
        public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            if string == "" {
                return true
            }
            
//            if let characterCount = textField.text?.count {
//                // CHECK FOR CHARACTER COUNT IN TEXT FIELD
//                if characterCount >= 1 {
//                    // RESIGN FIRST RERSPONDER TO HIDE KEYBOARD
//                    self.isFirstResponder.wrappedValue = false
//                    //return textField.resignFirstResponder()
//                }
//            }
            if string.count >= 1 {
                self.text.wrappedValue = string
                self.emojiChosen.wrappedValue = true
               
                
                self.isFirstResponder.wrappedValue = false

            }
            return true
        }
        
        //        func textField(_ textField: EmojiTextFieldUIKit, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        //
        //            if string == "" {
        //                    return true
        //            }
        //
        //            if let characterCount = textField.text?.count {
        //                    // CHECK FOR CHARACTER COUNT IN TEXT FIELD
        //                    if characterCount >= 1 {
        //                        // RESIGN FIRST RERSPONDER TO HIDE KEYBOARD
        //                        return textField.resignFirstResponder()
        //                    }
        //                }
        //                return true
        //        }
    }
}

