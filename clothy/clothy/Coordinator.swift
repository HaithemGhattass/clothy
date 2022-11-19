//
//  Coordinator.swift
//  clothy
//
//  Created by haithem ghattas on 16/11/2022.
//

import UIKit
import SwiftUI
class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    

    var picker: ImagePickerView
    
    init(picker: ImagePickerView) {
        self.picker = picker
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.originalImage] as? UIImage else { return }
     
        UsersViewModel().PostVideoUrl(url: selectedImage)
        self.picker.selectedImage = selectedImage
        self.picker.isPresented.wrappedValue.dismiss()
    }
    
}
