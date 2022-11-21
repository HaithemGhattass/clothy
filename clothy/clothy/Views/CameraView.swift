//
//  CameraView.swift
//  clothy
//
//  Created by haithem ghattas on 19/11/2022.
//

import Foundation
import SwiftUI


struct CameraView: View {
    @State private var isImagePickerDisplay = false
    
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State private var selectedImage: UIImage?
    var body: some View {
        ZStack {
            Color("Background").ignoresSafeArea()
            
        }
        .sheet(isPresented: self.$isImagePickerDisplay) {
            
            ImagePickerView(selectedImage: self.$selectedImage, sourceType: self.sourceType)
            
            
            
            
        }
    }
}
