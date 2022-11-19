//
//  SignInView.swift
//  clothy
//
//  Created by haithem ghattas on 4/11/2022.
//

import SwiftUI
import RiveRuntime

struct SignInView: View {
    @StateObject private var loginVM = LoginViewModel()
    @StateObject private var vm = UsersViewModel()


    @State var navigated = false
    @State var email = ""
    @State var password = ""
    @Binding var forgetpw : Bool
    @State var isLoading = false
    @Binding var showModal: Bool
    @Binding var showSignUp: Bool

    

    @Binding var show: Bool
    let userDefaults = UserDefaults.standard

    let check = RiveViewModel(fileName: "check", stateMachineName: "State Machine 1")
    let confetti = RiveViewModel(fileName: "confetti", stateMachineName: "State Machine 1")
    
    func logIn() {
        
        
       // ContentView().fetch = true
        isLoading = true
       
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            check.triggerInput("Check")
            
          
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            isLoading = false
            confetti.triggerInput("Trigger explosion")
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            withAnimation {
                showModal = false
                show = false
                
            }
            
            
        }
        userDefaults.set(loginVM.email, forKey: "email")
        print(loginVM.email)
    }
  

    
    
    var body: some View {
     
        VStack(spacing: 24) {
           
            Text("Sign In")
                .customFont(.largeTitle)
       
            
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
                    .customTextField(image: Image(systemName: "lock"))
            }
            
            Button {
                
                loginVM.connexion(completed: { (reponse,user)  in
                    
                    if (reponse) {
                        
                        //User() = reponse
                      //  let utilisateur = reponse as! User
                        
                        
                        logIn()
                        
                        
                    } else {
                        print("ERROR CANT CONNECT")
                    }
                    
                })
                

              // loginVM.login()
                
         //      DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
           //       loginVM.isAuthenticated ?
                    
                    
             //      logIn() : print("ERROR CANT CONNECT")

            //    }
              
            
                
                
            }
            
        label: {
                Label("Sign In", systemImage: "arrow.right")
                    .customFont(.headline)
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
                    .customFont(.subheadline)
                    .foregroundColor(.secondary)
                    .onTapGesture {
                        forgetpw = true ;
                      //  showModal = false
                        

                }
                
                
            }
         
            
         
            
            HStack {
                Rectangle().frame(height: 1).opacity(0.1)
                Text("OR").customFont(.subheadline2).foregroundColor(.black.opacity(0.3))
                Rectangle().frame(height: 1).opacity(0.1)
            }
            Button {
                withAnimation {
                    
                    showSignUp = true
                  //  showModal = false
                }
           
                
                
            } label: {
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
            HStack {
                Rectangle().frame(height: 1).opacity(0.1)
                .customFont(.subheadline2).foregroundColor(.black.opacity(0.3))
                Rectangle().frame(height: 1).opacity(0.1)
            }
            
            Text("Sign up with Email, Apple or Google")
                .customFont(.subheadline)
                .foregroundColor(.secondary)
            
            HStack {
                Image("Logo Email")
                Spacer()
                Image("Logo Apple")
                Spacer()
                Image("Logo Google")
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
        .overlay(
            ZStack {
         
                
                        if forgetpw {
                            withAnimation {
                                ForgotPWView( forgetpw: $forgetpw)
                               

                            }
                        }
                 
                if isLoading {
                    
                    check.view()
                        .frame(width: 100, height: 100)
                        .allowsHitTesting(false)
                }
                confetti.view()
                    .scaleEffect(3)
                    .allowsHitTesting(false)
            }
        )
    }
    
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView(forgetpw: .constant(true), showModal: .constant(true), showSignUp: .constant(true),  show: .constant(true))    }
}
