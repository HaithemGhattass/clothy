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
    @State private var details = false
    @State private var detailschoose = false
    @State private var typestring = ""
    @State private var categorystring = ""
    @State private var sizestring = ""
    @State private var imageClassifier = ""
    @State private var drawUIColor: UIColor = UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)
    @State private var drawOpacity: Double = 1.0
    @State private var drawHexNumber: String = "#FF0000"
    @State private var pointure = 28

    @State private var selectedcategorie = 4
    @State private var selectedsize = 1
    @State private var selectedtype = 1
    @State private var bgColor =
        Color(.sRGB, red: 0.98, green: 0.9, blue: 0.2)
    
        @ObservedObject var classifier: ImageClassifier
        
        var body: some View {
              VStack  {
                    HStack{
                        
                        Image(systemName: "photo").foregroundColor(.red)
                            
                            .onTapGesture {
                                isPresenting = true
                                sourceType = .photoLibrary
                            }
                        Spacer()
                        Image(systemName: "camera.fill").foregroundColor(.red)
                            .onTapGesture {
                               isPresenting = true
                               sourceType = .camera
                                          }
                            }
                    
                    .font(.title)
               //     .foregroundColor(Color("pink"))
                    Group {
                        if let imageClass = classifier.imageClass {
                         
                            HStack{
                                Text(imageClass)
                                    .bold()
                                Circle()
                                    .fill(Color(uiImage?.averageColor ?? .clear))
                                    .frame(width: 15, height: 15)
                          
                            }.onAppear{
                                imageClassifier = imageClass
                                bgColor = Color(uiImage?.averageColor ?? .clear)
   
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
                      
                        .opacity(0)
                        .overlay(
                            Group {
                                if uiImage != nil {
                                    VStack{
                                        Image(uiImage: uiImage!)
                                            .resizable()
                                            .scaledToFit()
                                            .onTapGesture{
                                                if(classifier.imageClass == "shoes"){
                                                    detailschoose.toggle()
                                                }else {
                                                    details.toggle()
                                                }
                                                    
                                            }
                                    }
                                  
                                }
                                if uiImage == nil {
                                    VStack(spacing: 30.0){
                                        Text("Take a photo from your camera / gallery ")
                                            .frame(maxWidth : 430)
                                            .font(.title3)
                                            .fontWeight(.bold)
                                        Text("make sure to choose a clear photo")
                                            .frame(maxWidth : 200)
                                            .font(.body)
                                            .multilineTextAlignment(.center)
                                    }
                                }
                            }
                        )
                }
                .background(
                    Image("Blob 1")
                        .offset(x: 250 , y: -100)
                )
                .sheet(isPresented: $details) {
                    clothesdetail
                        .onAppear{
                            bgColor = Color(uiImage?.averageColor ?? .clear)
                            getColorsFromPicker(pickerColor: bgColor)
                            if(classifier.imageClass == "outwear"){
                                selectedcategorie = 3
                             
                            }
                           if(classifier.imageClass == "t-shirt"){
                               selectedcategorie = 2
                             
                            }
                           if(classifier.imageClass == "shoes"){
                                selectedcategorie = 1
                              
                            }
                           if(classifier.imageClass == "hat"){
                                selectedcategorie = 0
                               
                            }

                        }
                }
                .sheet(isPresented: $detailschoose) {
                    shoesdetail
                        .onAppear{
                            bgColor = Color(uiImage?.averageColor ?? .clear)
                            getColorsFromPicker(pickerColor: bgColor)
                         
                                selectedcategorie = 1
                              
                          

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
    func getColorsFromPicker(pickerColor: Color) {
            let colorString = "\(pickerColor)"
            let colorArray: [String] = colorString.components(separatedBy: " ")

            if colorArray.count > 1 {
                var r: CGFloat = CGFloat((Float(colorArray[1]) ?? 1))
                var g: CGFloat = CGFloat((Float(colorArray[2]) ?? 1))
                var b: CGFloat = CGFloat((Float(colorArray[3]) ?? 1))
                let alpha: CGFloat = CGFloat((Float(colorArray[4]) ?? 1))

                if (r < 0.0) {r = 0.0}
                if (g < 0.0) {g = 0.0}
                if (b < 0.0) {b = 0.0}

                if (r > 1.0) {r = 1.0}
                if (g > 1.0) {g = 1.0}
                if (b > 1.0) {b = 1.0}

                // Update UIColor
                drawUIColor = UIColor(red: r, green: g, blue: b, alpha: alpha)
                // Update Opacity
                drawOpacity = Double(alpha)

                // Update hex
                let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
                drawHexNumber = String(format: "#%06X", rgb)
            }
        }


        func resetColorPickerWithUIColor() {
            let color: UIColor = drawUIColor
            let r: Double = Double(color.rgba.red)
            let g: Double = Double(color.rgba.green)
            let b: Double = Double(color.rgba.blue)
            bgColor = Color(red: r, green: g, blue: b, opacity: drawOpacity)
        }
    



    var clothesdetail: some View {
        NavigationView {
            Form {
                Section(header: Text("General Information")) {
                    Picker("Category", selection: $selectedcategorie) {
                        Text("hat").tag(0)
                        Text("shoes").tag(1)
                        Text("t-shirt").tag(2)
                        Text("outwear").tag(3)
                        Text("jeans").tag(4)
                    }
                    .pickerStyle(.menu)
                    ColorPicker("Color", selection: $bgColor)
                    Picker("Type", selection: $selectedtype) {
                        Text("Formal").tag(0)
                        Text("Sport").tag(1)
                        Text("Evereyday").tag(2)
                        
                        
                    }
                    .pickerStyle(.menu)
                    
                }
    
                    Section(header: Text("Size")) {
            
                            Picker("size", selection: $selectedsize) {
                                Text("S").tag(0)
                                Text("M").tag(1)
                                Text("L").tag(2)
                                Text("XL").tag(3)
                                
                            }
                        
                        .pickerStyle(.segmented)
                    }
                
            

                
            }
            .navigationTitle("Add Details")
            .navigationBarItems(trailing: Button{
                if(selectedtype == 0){
                    categorystring = "Formal"
                }
                if(selectedtype == 1){
                    categorystring = "Sport"
                }
                if(selectedtype == 2){
                    categorystring = "Everyday"
                }
                if(selectedcategorie == 0){
                    typestring = "hat"
                }
                if(selectedcategorie == 1){
                    typestring = "shoes"
                }
                if(selectedcategorie == 2){
                    typestring = "t-shirt"
                }
                if(selectedcategorie == 3){
                    typestring = "outwear"
                }
                if(selectedcategorie == 4){
                    typestring = "jean"
                }
                if(selectedsize == 0){
                    sizestring = "S"
                }
                if(selectedsize == 1){
                    sizestring = "M"
                }
                if(selectedsize == 2){
                    sizestring = "L"
                }
                if(selectedsize == 3){
                    sizestring = "XL"
                }
                getColorsFromPicker(pickerColor: bgColor)
                ovm.PostImage(url: uiImage!, type: categorystring, category: typestring, taille: sizestring,color:drawHexNumber)
                details.toggle()
            }label: {
                Text("Done").bold()
            })
        }

        
        }
    var shoesdetail: some View {
        NavigationView {
            Form {
                Section(header: Text("General Information")) {
                    Picker("Category", selection: $selectedcategorie) {
                        
                        Text("shoes").tag(1)
                       
                    }
                    .pickerStyle(.menu)
                    ColorPicker("Color", selection: $bgColor)
                    Picker("Type", selection: $selectedtype) {
                        Text("Formal").tag(0)
                        Text("Sport").tag(1)
                        Text("Evereyday").tag(2)
                        
                        
                    }
                    .pickerStyle(.menu)
                    
                }
    
                    Section(header: Text("Size")) {
            
                            Picker("size", selection: $pointure) {
                                ForEach(28...52, id: \.self) { //<-
                                                           Text("\($0)")
                                                       }
                                
                            }
                        
                            .pickerStyle(.wheel)
                    }
                
            

                
            }
            .navigationTitle("Add Details")
            .navigationBarItems(trailing: Button{
                if(selectedtype == 0){
                    categorystring = "Formal"
                }
                if(selectedtype == 1){
                    categorystring = "Sport"
                }
                if(selectedtype == 2){
                    categorystring = "Everyday"
                }
                if(selectedcategorie == 0){
                    typestring = "hat"
                }
                if(selectedcategorie == 1){
                    typestring = "shoes"
                }
                if(selectedcategorie == 2){
                    typestring = "shoes"
                }
                if(selectedcategorie == 3){
                    typestring = "shoes"
                }
                if(selectedcategorie == 4){
                    typestring = "shoes"
                }
  
                getColorsFromPicker(pickerColor: bgColor)
                let str1 = "\(pointure)"
                ovm.PostImage(url: uiImage!, type: categorystring, category: typestring, taille: str1,color:drawHexNumber)
                detailschoose.toggle()
            }label: {
                Text("Done").bold()
            })
        }

        
        }
    }


struct AddClothesCameraView_Previews: PreviewProvider {
    static var previews: some View {
        AddClothesCameraView(sourceType: .photoLibrary, classifier: ImageClassifier())
    }
}

extension UIColor {
    var rgba: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0

        getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        return (red, green, blue, alpha)
    }
}
