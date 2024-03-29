//
//  ImagePicker.swift
//  Social-App
//
//  Created by Chirag's on 15/09/20.
//

import SwiftUI
import PhotosUI

struct ImagePicker: UIViewControllerRepresentable {
    
    @Binding var picker: Bool
    @Binding var img_Data: Data
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        config.selectionLimit = 1
        let controller = PHPickerViewController(configuration: config)
        controller.delegate = context.coordinator
        return controller
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
        
    }
    
    class Coordinator: NSObject,PHPickerViewControllerDelegate {
        var parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            if results.isEmpty {
                self.parent.picker.toggle()
                return
            }
            let item = results.first!.itemProvider
            if item.canLoadObject(ofClass: UIImage.self) {
                item.loadObject(ofClass: UIImage.self) { (image, error) in
                    if error != nil {
                        return
                    }
                    let imageData = image as! UIImage
                    DispatchQueue.main.async {
                        self.parent.img_Data = imageData.jpegData(compressionQuality: 0.5)!
                        self.parent.picker.toggle()
                    }
                }
            }
        }
    }
}
