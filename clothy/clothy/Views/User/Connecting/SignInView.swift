//
//  SignInView.swift
//  ClothyApp
//
//  Created by haithem ghattas on 17/12/2022.
//

import SwiftUI
import RiveRuntime
struct SignInView: View {
    @Binding var logged : Bool
    @State var isLoading = false
    @State var email : String = ""
    @State var password : String = ""
    @Binding var forgetpw : Bool
    @Binding var showSignUp : Bool
    @Binding var showsignin : Bool
    @StateObject private var Vm = UsersViewModel()
    let confetti = RiveViewModel(fileName: "confetti", stateMachineName: "State Machine 1")
    let check = RiveViewModel(fileName: "check", stateMachineName: "State Machine 1")

    
    var body: some View {
        
        VStack(spacing: 24) {
            Text("Sign In")
                .font(.largeTitle).bold()
            VStack(alignment: .leading) {
                Text("Email")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                TextField("", text: $email)
                    .customTextField()
            }
            VStack(alignment: .leading) {
                Text("Password")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                SecureField("", text: $password)
                    .customTextField(image: Image(systemName: "lock"))
            }
            Button {
               let newmail = email.firstUppercased
                Vm.connexion(email: newmail, password: password,completed: { (reponse)  in

                if (reponse) {
                    //logIn()
                    isLoading = true
                    withAnimation{
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            check.triggerInput("Check")
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                            isLoading = false
                            confetti.triggerInput("Trigger explosion")
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                            withAnimation {
                                logged = true
                                UserDefaults.standard.set(true, forKey: "logged")
                                
                            }
                            
                            
                        }

                       
                    
                    }
   
                   print(password)
                    print(newmail)
                    print("connected")
                } else {
                    print(password)
                    print(email)
                    print("ERROR CANT CONNECT")
                }

            })
            
        }
        
    label: {
            Label("Sign In", systemImage: "arrow.right")
                .font(.headline)
                .padding(20)
                .frame(maxWidth: .infinity)
                .background(Color(hex: "5f9fff"))
                .foregroundColor(.white)
                .cornerRadius(20, corners: [.topRight, .bottomLeft, .bottomRight])
                .cornerRadius(8, corners: [.topLeft])
            .shadow(color: Color(hex: "5f9fff").opacity(0.5), radius: 20, x: 0, y: 10)
    }
            HStack{
                Text("Forgot password?  Reset")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .onTapGesture {
                        forgetpw.toggle()
                        showsignin.toggle()
                }
            }
            VStack{
                HStack {
                    Rectangle().frame(height: 1).opacity(0.1)
                    Text("OR").font(.subheadline).foregroundColor(.black.opacity(0.3))
                    Rectangle().frame(height: 1).opacity(0.1)
                    
                }
                Button(action: {
//                    self.loginVM.facebookLogin { completionData,data  in
//                            // Do operation with String
//                           // print(completionData);
//                        if(completionData){
//                            print(completionData)
//                            logIn()
//                        }
//
//                        }
                }) {
                    Text("login with facebook")
                }
                Button {
                    withAnimation {
                        showsignin.toggle()
                        showSignUp.toggle()
                      //  showModal = false
                    }
               
                    
                    
                } label: {
                    Label("Sign Up", systemImage: "arrow.right")
                        .font(.headline)
                        .padding(20)
                        .frame(maxWidth: .infinity)
                        .background(Color(hex: "5f9fff"))
                        .foregroundColor(.white)
                        .cornerRadius(20, corners: [.topRight, .bottomLeft, .bottomRight])
                        .cornerRadius(8, corners: [.topLeft])
                    .shadow(color: Color(hex: "5f9fff").opacity(0.5), radius: 20, x: 0, y: 10)
                }
                HStack {
                    Rectangle().frame(height: 1).opacity(0.1)
                    .font(.subheadline).foregroundColor(.black.opacity(0.3))
                    Rectangle().frame(height: 1).opacity(0.1)
                    
                }
                Text("Sign up with Email, Apple or Google")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                HStack {
                    
                    Image("Logo Email").onTapGesture {
                    //    login.toggle()
                    }
                    Spacer()
                 
                    Image("Logo Apple")
                    Spacer()
                    Image("Logo Google")
                }

                    
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

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView(logged: .constant(false), forgetpw: .constant(false), showSignUp: .constant(false), showsignin: .constant(false))
    }
}
