//
//  AddClothesCameraView.swift
//  clothy
//
//  Created by haithem ghattas on 21/11/2022.
//

import SwiftUI

struct AddClothesCameraView: View {
    @State var isPresenting: Bool = false
        @State var uiImage: UIImage?
    @State  var sourceType: UIImagePickerController.SourceType
        @ObservedObject var classifier: ImageClassifier
        
        var body: some View {
            VStack{
                HStack{
                    Image(systemName: "photo")
                        .onTapGesture {
                            isPresenting = true
                            sourceType = .photoLibrary
                        }
                    
                    Image(systemName: "camera")
                        .onTapGesture {
                                                isPresenting = true
                                                sourceType = .camera
                                            }
                }
                
                .font(.title)
                .foregroundColor(.blue)
                Group {
                    if let imageClass = classifier.imageClass {
                        HStack{
                            
                            Text(imageClass)
                                .bold()
                            
                            Circle()
                                .fill(Color(uiImage?.averageColor ?? .clear))

                                .frame(width: 15, height: 15)
                           
                        }
                    } else {
                        HStack{
                            Text("Image categories: NA")
                                .font(.caption)
                         
                                
                        }
                    }
                }
                .font(.subheadline)
                .padding()
                
                Rectangle()
                    .strokeBorder()
                    .foregroundColor(.yellow)
                    .frame(width: 400, height: 600)
                    .overlay(
                        Group {
                            if uiImage != nil {
                                Image(uiImage: uiImage!)
                                    .resizable()
                                    .scaledToFit()
                             
                                  
                            }
                        }
                    )
                
                
                VStack{
                    Button(action: {
                        if uiImage != nil {
                            classifier.detect(uiImage: uiImage!)
                        }
                    }) {
                        Image(systemName: "bolt.fill")
                            .foregroundColor(.orange)
                            .font(.title)
                    }
                    
                    
                   
                }
            }
            
            .sheet(isPresented: $isPresenting){
                      ImgPicker(uiImage: $uiImage, isPresenting:  $isPresenting, sourceType: $sourceType)
                          .onDisappear{
                              if uiImage != nil {
                                  classifier.detect(uiImage: uiImage!)
                              }
                          }
                      
                  }
            
            .padding()
        }
    }


struct AddClothesCameraView_Previews: PreviewProvider {
    static var previews: some View {
        AddClothesCameraView(sourceType: .photoLibrary, classifier: ImageClassifier())
    }
}
