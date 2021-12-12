//
//  ImagePicker.swift
//  senes
//
//  Created by Apprenant 49 on 03/12/2021.
//

import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var inputImage: UIImage?
    let sourceType: UIImagePickerController.SourceType
    @Environment(\.presentationMode) var presentationMode
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let pickerController = UIImagePickerController()
        pickerController.delegate = context.coordinator
        if UIImagePickerController.isSourceTypeAvailable(sourceType) {
            pickerController.sourceType = sourceType
        }
        return pickerController
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
}


extension ImagePicker {

    final class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let control: ImagePicker

        init(_ control: ImagePicker) {
            self.control = control
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                control.inputImage = uiImage
            }
            dismiss()
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            dismiss()
        }
        
        private func dismiss() {
            control.presentationMode.wrappedValue.dismiss()
        }
    }
}

struct LoaderPicture {
    var isImagePickerShown : Bool = false
    var inputImage: UIImage?
    var sourceType = UIImagePickerController.SourceType.photoLibrary
    var image: Image?
}
