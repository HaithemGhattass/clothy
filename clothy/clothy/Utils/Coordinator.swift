//
//  Coordinator.swift
//  ClothyApp
//
//  Created by haithem ghattas on 19/12/2022.
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
     
       
        self.picker.selectedImage = selectedImage
        self.picker.isPresented.wrappedValue.dismiss()
        
        UsersViewModel().PostVideoUrl(url: selectedImage)
    }
    
}
