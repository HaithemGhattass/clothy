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
    @State var user: User?
    @State var options = ["Male", "Female", "Other"]// 1
    @State var isdisabled = false
    // 2





    @State var isLoading = false
    @Binding var showSignUp: Bool
  
   
    
    var body: some View {
        
        
      
                ScrollView(showsIndicators: false) {
                Text("Sign Up")
                    .customFont(.largeTitle)
               
                    .customFont(.headline)
                    VStack(spacing: 24) {
                        VStack(alignment: .leading) {
                            Text("Pseudo")
                                .customFont(.subheadline)
                                .foregroundColor(.secondary)
                            TextField("", text: $loginVM.pseudo)
                                .customTextField(image: Image(systemName: "person.circle"))
                            
                        }
                        
                        VStack(alignment: .leading) {
                            Text("First Name")
                                .customFont(.subheadline)
                                .foregroundColor(.secondary)
                            TextField("", text: $loginVM.firstname)
                                .customTextField(image: Image(systemName: "person.circle"))
                        }
                        VStack(alignment: .leading) {
                            Text("Last Name")
                                .customFont(.subheadline)
                                .foregroundColor(.secondary)
                            TextField("", text: $loginVM.lastname)
                                .customTextField(image: Image(systemName: "person.circle"))
                        }
                        
                        VStack(alignment: .leading) {
                            Text("Email")
                                .customFont(.subheadline)
                                .foregroundColor(.secondary)
                            TextField("", text: $loginVM.email)
                                .customTextField()
                        }
                        VStack(alignment: .leading) {
                            Text("phone number")
                                .customFont(.subheadline)
                                .foregroundColor(.secondary)
                            TextField("", text: $loginVM.phone)
                                .customTextField(image: Image(systemName: "phone.circle"))
                                .keyboardType(.numberPad)
                        }
                        
                        
                        VStack(alignment: .leading) {
                            Text("Password")
                                .customFont(.subheadline)
                                .foregroundColor(.secondary)
                            SecureField("", text: $loginVM.password)
                                .customTextField(image: Image(systemName: "lock"))
                        }
                        
                  
                        VStack(alignment: .leading) {
                            DatePicker("Birthdate", selection: $loginVM.birthdate,in: ...Date(),displayedComponents: [.date])
                                .datePickerStyle(.automatic)
                                .accentColor(Color(hex: "5f9fff"))
                                .customFont(.subheadline)
                                .foregroundColor(.secondary)
                                .padding(15)
                            
                        }
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Gender")
                            .customFont(.subheadline)
                            .foregroundColor(.secondary)
                        
                            .padding(.leading, 10)
                        Picker("", selection: $loginVM.gender) { // 3
                            ForEach(options, id: \.self) { item in // 4
                                Text(item) // 5
                            }
                        }
                        .pickerStyle(.segmented)
                        .foregroundColor(.secondary)
                        .accentColor(Color(hex: "5f9fff"))
                        .padding(15)
                        
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


                    
                    
                }
               
                label: {
                    Label("Sign Up", systemImage: "arrow.right")
                        .customFont(.headline)
                        .padding(20)
                        .frame(maxWidth: .infinity)
                        .background(Color(hex: "5f9fff"))
                        .foregroundColor(.white)
                        .cornerRadius(20, corners: [.topRight, .bottomLeft, .bottomRight])
                        .cornerRadius(8, corners: [.topLeft])
                    .shadow(color: Color(hex: "5f9fff").opacity(0.5), radius: 20, x: 0, y: 10)
                }
                .disabled(self.loginVM.firstname.isEmpty || self.loginVM.lastname.isEmpty)
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

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView(showSignUp: .constant(true))    }
}
