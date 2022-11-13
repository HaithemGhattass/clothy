//
//  SignUpView.swift
//  clothy
//
//  Created by haithem ghattas on 7/11/2022.
//

import SwiftUI
import RiveRuntime

struct SignUpView: View {

    @State var navigated = false
    @State var email = ""
    @State var password = ""
    @State var passwordcomfirm = ""
    @State var phone = ""
    @State var pseudo = ""
    @State var prefrences = ""
    @State var firstname = ""
    @State var lastname = ""
    @StateObject private var loginVM = LoginViewModel()
    //var user = User(from: <#Decoder#>)




    @State var isLoading = false
    @Binding var showSignUp: Bool
  
   
    
    var body: some View {
        
        
        ScrollView {
            VStack(spacing: 24) {
                Text("Sign Up")
                    .customFont(.largeTitle)
               
                    .customFont(.headline)
                
                VStack(alignment: .leading) {
                    Text("Pseudo")
                        .customFont(.subheadline)
                        .foregroundColor(.secondary)
                    TextField("", text: $loginVM.pseudo)
                        .customTextField()
                }
                
                VStack(alignment: .leading) {
                    Text("First Name")
                        .customFont(.subheadline)
                        .foregroundColor(.secondary)
                    TextField("", text: $loginVM.firstname)
                        .customTextField()
                }
                VStack(alignment: .leading) {
                    Text("Last Name")
                        .customFont(.subheadline)
                        .foregroundColor(.secondary)
                    TextField("", text: $loginVM.lastname)
                        .customTextField()
                }
                
                VStack(alignment: .leading) {
                    Text("Email")
                        .customFont(.subheadline)
                        .foregroundColor(.secondary)
                    TextField("", text: $loginVM.email)
                        .customTextField()
                }
                
                VStack(alignment: .leading) {
                    Text("Password")
                        .customFont(.subheadline)
                        .foregroundColor(.secondary)
                    SecureField("", text: $loginVM.password)
                        .customTextField(image: Image("Icon Lock"))
                }
                VStack(alignment: .leading) {
                    Text("phone")
                        .customFont(.subheadline)
                        .foregroundColor(.secondary)
                    TextField("", text: $loginVM.phone)
                        .customTextField()
                }
                
                
               
              
                
                
                Button {
                    loginVM.inscription(completed: { (success) in
                        
                        if success {
                            
                           withAnimation{
                         
                                showSignUp = false
                            }

                           
                        } else {
                           print("fama mochkla ")
                            

                        }

                    })


                    
                    
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

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView(showSignUp: .constant(true))    }
}
