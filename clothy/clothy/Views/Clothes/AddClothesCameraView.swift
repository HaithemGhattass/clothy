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
    @StateObject var ovm = OutfitViewModel()
    @State var alertedit = false
    @State private var color = Color.red

        @ObservedObject var classifier: ImageClassifier
        
        var body: some View {
            VStack{
                HStack{
                    Image(systemName: "photo")
                        .onTapGesture {
                            isPresenting = true
                            sourceType = .photoLibrary
                        }
                    Spacer()
                    Image(systemName: "camera.fill")
                        .onTapGesture {
                                                isPresenting = true
                                                sourceType = .camera
                                            }
                }
                
                .font(.title)
                .foregroundColor(Color("pink"))
                Group {
                    if let imageClass = classifier.imageClass {
                        HStack{
                            
                            Text(imageClass)
                                .bold()
                          //  color = uiImage.averageColor
                           

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
                
                  //  .foregroundColor(Color("pink"))
                   
                    .opacity(0)
                    .background(.ultraThinMaterial)
                    .mask(RoundedRectangle(cornerRadius: 30,style: .continuous))
                   // .cornerRadius(30)
                //.mask(RoundedRectangle(cornerRadius: 30,style: .continuous))
                    .strokeStyle()
                    .shadow(color: Color("Shadow").opacity(0.3), radius: 10, x: 0, y: 10)
                
                    //.frame(width: 400, height: 600)
                    .overlay(
                        Group {
                            if uiImage != nil {
                              
                                   
                                VStack{
                                    Image(uiImage: uiImage!)
                                        .resizable()
                                        .scaledToFit()
                                    Button(action: {
                                        if uiImage != nil {
                                            classifier.detect(uiImage: uiImage!)
                                                ovm.PostImage(url: uiImage!,type: classifier.imageClass!, completed: { (reponse)  in
                                                    
                                                    if (reponse) {
                                                        
                                                        //User() = reponse
                                                        //  let utilisateur = reponse as! User
                                                        
                                                        print("worked")
                                                        // logIn()
                                                        
                                                        
                                                    } else {
                                                        print("ERROR CANT CONNECT")
                                                    }
                                                    
                                                })
                                            

                                            
                                        }
                                    }) {
                                        Image(systemName: "plus.circle.fill")
                                            .foregroundColor(Color("pink"))
                                            .font(.system(size: 50))
                                           
                                            .font(.title)
                                    }.disabled(classifier.imageClass == "Image categories: NA" || classifier.imageClass == "Please take a clearer photo" ? true : false)
                                    
                                    
                                   
                                }
                                    
                                
                             
                                  
                            }
                            if uiImage == nil {
                                VStack(spacing: 30.0){
                                    Text("Take a photo from your camera / gallery ")
                                        .frame(maxWidth : 430)
                                        .font(.title3)
                                       // .foregroundColor(.black)
                                        .fontWeight(.bold)
                                    Text("make sure to choose a clear photo")
                                       
                                        .frame(maxWidth : 200)
                                        .font(.body)
                                    
                                     //   .foregroundColor(.black)
                                        .multilineTextAlignment(.center)
                                    
        
                                    ZStack{
                                       
                                        Image("hat")
                                            .offset(x: -90 , y: -120)
                                            .shadow(color: Color("Shadow").opacity(0.2), radius: 10, x: 0, y: 10)

                                        
                                        Image("shoes")
                                            .offset( y: 65)
                                            .shadow(color: Color("Shadow").opacity(0.3), radius: 10, x: 0, y: 10)

                                        Image("shirt")
                                            .offset(x: 120 , y: -100)
                                            .shadow(color: Color("Shadow").opacity(0.6), radius: 10, x: 0, y: 10)

                                        
                                        


                                    }
                                    

                                }
                                
                            }
                        }
                    )
                
                
                
            }
            .background(
        Image("Blob 1")
            .offset(x: 250 , y: -100)
    )
            
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
