//
//  PrefrencesView.swift
//  clothy
//
//  Created by haithem ghattas on 7/11/2022.
//

import SwiftUI

struct PrefrencesView: View {
    @State var SelectedItem = false
    @State var BindingSelection = false
    private var gridItemLayout = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    @State private var didTap:Bool = false
    @State var yourCondition: Int = 1
    var colorToShow: Color {
            switch didTap {
            case true:
                    return Color(UIColor(red: 0.5, green: 0.2, blue: 0.8, alpha: 0.5))
            
              case false:
                    return .red
            }
        }
    
    var body: some View {
        

        
        
        ScrollView {
            VStack(spacing: 24) {
                Text("Tell us about your prefrences")
                    .customFont(.largeTitle)
               
                    .customFont(.headline)
                
                
                LazyVGrid( columns: gridItemLayout, spacing: 20) {
                   
                    
                   Button(action: {
                           self.didTap = !didTap
                       
                   }, label: {
                       PrefButton(buttonText: "test", buttonColor:Color(hex: "FFFFFF"))
                           .shadow(color:colorToShow,radius: 20, x: 0, y: 10)
                           
                       
                       
                         
                   }
                   
                   )
                 
                   
                  
                }
                
              
               
             
                
                
                Button {
                  
                    
                    
                } label: {
                    Label("Sign Up", systemImage: "arrow.right")
                        .customFont(.headline)
                        .padding(20)
                        .frame(maxWidth: .infinity)
                        .background(Color(hex: "F77D8E"))
                        .foregroundColor(.white)
                        .cornerRadius(20, corners: [.topRight, .bottomLeft, .bottomRight])
                        .cornerRadius(8, corners: [.topLeft])
                    .shadow(color: Color(hex: "F77D8E").opacity(0.5), radius: 20, x: 0, y: 10)
                }
                HStack {
                    Rectangle().frame(height: 1).opacity(0.1)
                    .customFont(.subheadline2).foregroundColor(.black.opacity(0.3))
                    Rectangle().frame(height: 1).opacity(0.1)
                }
                
              
              
            }
            .padding(30)
            .background(.regularMaterial)
            .mask(RoundedRectangle(cornerRadius: 20, style: .continuous))
            .shadow(color: Color("Shadow").opacity(0.3), radius: 5, x: 0, y: 3)
            .shadow(color: Color("Shadow").opacity(0.3), radius: 30, x: 0, y: 30)
            .overlay(
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .stroke(.linearGradient(colors: [.white.opacity(0.8), .white.opacity(0.1)], startPoint: .topLeading, endPoint: .bottomTrailing))
            )
        .padding()
        }
        
    }
}


struct PrefrencesView_Previews: PreviewProvider {
    static var previews: some View {
        PrefrencesView()
    }
}
