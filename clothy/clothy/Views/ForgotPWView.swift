//
//  ForgotPWView.swift
//  clothy
//
//  Created by haithem ghattas on 8/11/2022.
//

import SwiftUI

struct ForgotPWView: View {
    @State var email = ""
    @State var textbutton = "Reset pasword"
    @State var emaillabel = "email"
    @State var confirmpw = ""
    @State var newpwd = ""
    @State var saveMail = ""


    @State private var pressed = false
    @State private var trueCode = false
    @State private var confirmpwtf = false
    @State private var validatepw = false
    @State private var back = true
    @State private var fals = false
    @Binding var forgetpw: Bool


    @StateObject private var loginVM = LoginViewModel()




    
    var body: some View {
        VStack(spacing: 24) {
            
            Text("Forgot password")
                .customFont(.title2)
            VStack(alignment: .leading) {
              
               
                if(confirmpwtf){
                    Text(" passwod")
                    .customFont(.subheadline)
                    .foregroundColor(.secondary)
                    TextField("", text: $confirmpw)
                    .customTextField()
                    
                    Text("comfirm passwod")
                    .customFont(.subheadline)
                    .foregroundColor(.secondary)
                    TextField("", text: $newpwd)
                    .customTextField()
                } else {
                    Text(emaillabel)
                        .customFont(.subheadline)
                        .foregroundColor(.secondary)
                    TextField("", text: $email)
                        .customTextField()
                }
                
                Button {
                    if(pressed){
                        print(saveMail)
                        // self.emaillabel="code true"
                        loginVM.EnterfpwCode(email: saveMail, code: Int(self.email) ?? 0000, completed: { (success) in
                            if(success){
                            //    trueCode = true
                                confirmpwtf = true
                                email = ""
                                emaillabel = "enter password"
                                self.textbutton = "enter passwod"
                                
                                
                            }else{
                                print("error code errer")
                            }
                            //    if(self.email == "aa"){
                            //       trueCode = true
                            
                        })
                   
                            if( confirmpwtf){
                                if((confirmpw == newpwd)&&(newpwd != "")){
                                    forgetpw = false

                                }
                             //   SignInView().showSignUp = false

                        }
                    
                        
                        
                        
                    }else {
                       
                        if(self.email != ""){
                            print(self.email)
                            loginVM.forgorPW(email: self.email, completed: { (success) in
                                if(success){
                                    saveMail = self.email
                                    pressed = true
                                    self.email = ""
                                    print(saveMail)
                                    self.textbutton = "Enter Code"
                                    self.emaillabel = "code"
                                    //pressed = true
                                    self.textbutton = "Enter Code"
                                    self.emaillabel = "code"
                                print("success")
                                }else{
                                    print("erre no maail")
                                }
                            }
)
                        }
                    }
                    
                } label: {
                    Label(textbutton, systemImage: "arrow.right")
                        .customFont(.headline)
                        .padding(20)
                        .frame(maxWidth: .infinity)
                        .background(Color(hex: "F77D8E"))
                        .foregroundColor(.white)
                        .cornerRadius(20, corners: [.topRight, .bottomLeft, .bottomRight])
                        .cornerRadius(8, corners: [.topLeft])
                        .shadow(color: Color(hex: "F77D8E").opacity(0.5), radius: 20, x: 0, y: 10)
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

struct ForgotPWView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPWView( forgetpw: .constant(true))
    }
}
