//
//  ImgPicker.swift
//  clothy
//
//  Created by haithem ghattas on 21/11/2022.
//

import SwiftUI
import UIKit

struct ImgPicker: UIViewControllerRepresentable {
    @Binding var uiImage: UIImage?
     @Binding var isPresenting: Bool
    @Binding var sourceType: UIImagePickerController.SourceType

      

     func makeUIViewController(context: Context) -> UIImagePickerController {

       let imgPicker = UIImagePickerController()
         imgPicker.sourceType = sourceType


         imgPicker.delegate = context.coordinator

       return imgPicker

     }


     func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {

     }

    
     typealias UIViewControllerType = UIImagePickerController
     

     func makeCoordinator() -> Coordinator {

       Coordinator(self)

     }
      

    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
            
            let parent: ImgPicker
                    
            func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
                parent.uiImage = info[.originalImage] as? UIImage
                parent.isPresenting = false
            }
            
            func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
                parent.isPresenting = false
            }
            
            init(_ imgPicker: ImgPicker) {
                self.parent = imgPicker
            }
            
        }

   }
