//
//  CustomTextView.swift
//  senes
//
//  Created by Apprenant 49 on 03/12/2021.
//

import SwiftUI
//MARK: - MAJ: OUI (suprimer la preview)


struct TextView: UIViewRepresentable {
    
    @Binding var textDescription: String
    
    
    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        
        textView.delegate                   = context.coordinator
        textView.autocapitalizationType     = .sentences
        textView.isSelectable               = true
        textView.isUserInteractionEnabled   = true
        textView.keyboardType               = .default
        textView.textColor                  = .lightGray
        textView.font                       = .boldSystemFont(ofSize: 20)
        
        return textView
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = textDescription
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator($textDescription)
    }
    
    class Coordinator: NSObject, UITextViewDelegate {
        var text: Binding<String>
        
        init(_ text: Binding<String>) {
            self.text = text
        }
        
        
        func textViewDidBeginEditing(_ textView: UITextView) {
            if textView.text == "Ecrit un message..." || textView.text == "Ecrit un message..." {
                textView.text = nil
                textView.textColor = UIColor.black
            }
        }
        
        func textViewDidChange(_ textView: UITextView) {
            if textView.text == "\n\n" {
                
                textView.text = "Ecrit un message..."
                textView.textColor = UIColor.lightGray
                textView.resignFirstResponder()
            }
            
            self.text.wrappedValue = textView.text
            
            if textView.text.hasSuffix("\n\n") {
                textView.resignFirstResponder()
            }
        }
    }
}
