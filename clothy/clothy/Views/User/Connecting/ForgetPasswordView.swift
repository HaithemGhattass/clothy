//
//  ForgetPasswordView.swift
//  ClothyApp
//
//  Created by haithem ghattas on 17/12/2022.
//

import SwiftUI

struct ForgetPasswordView: View {
    @StateObject private var Vm = UsersViewModel()
    @Binding var showSignIn : Bool
    @Binding var forgetpw : Bool
    @State var findmail = true
    @State var notstrongpass = false
    @State var comfirmpw = false
    @State var code = false
    @State var unvalidcode = false
    @State var noexist = false
    @State var shouldmatch = false
    @State var email = ""
    @State var recupcode = ""
    @State var password = ""
    @State var passwordcomfirm = ""

    var body: some View {
        VStack(spacing: 24) {
            
            Text("Forgot password")
                .font(.title2).bold()
            if findmail {
                enterEmail
            }
            if code {
                enterCode
            }
            if comfirmpw {
                comfirmpassword
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
    var enterEmail: some View {
        VStack(alignment: .leading) {
            Text("email")
                .font(.subheadline)
                .foregroundColor(.secondary)
            + Text(noexist ? " does not exist" : "")
                .font(.subheadline)
                .foregroundColor(.red)
            TextField("", text: $email)
                .customTextField()
                .keyboardType(.emailAddress)
            Button{
                let newmail = email.firstUppercased
                Vm.forgotpassword(email: newmail, completed: { (success) in
                    if(success){
                        code.toggle()
                        findmail.toggle()
                    }else{
                        noexist = true
                    }
                }
                )
               
            }label: {
                Label("Reset pasword", systemImage: "arrow.right")
                    .font(.headline)
                    .padding(20)
                    .frame(maxWidth: .infinity)
                    .background(Color(hex: "5f9fff"))
                    .foregroundColor(.white)
                    .cornerRadius(20, corners: [.topRight, .bottomLeft, .bottomRight])
                    .cornerRadius(8, corners: [.topLeft])
                    .shadow(color: Color(hex: "5f9fff").opacity(0.5), radius: 20, x: 0, y: 10)
            }
        }
    }
    var enterCode: some View {
        VStack(alignment: .leading) {
            Text("code")
                .font(.subheadline)
                .foregroundColor(.secondary)
            + Text(unvalidcode ? " is wrong" : "")
                .font(.subheadline)
                .foregroundColor(.secondary)
            TextField("", text: $recupcode)
                .customTextField(image:Image(systemName: "keyboard"))
                .keyboardType(.numberPad)
                
            Button{
                let newmail = email.firstUppercased

                Vm.forgotpasswordcode(email: newmail, code: Int(recupcode) ?? 0, completed:  { (success) in
                    if (success){
                        comfirmpw.toggle()
                        code.toggle()
                    }else{
                        unvalidcode = true
                    }
                        
                })
              
            }label: {
                Label("Enter Code", systemImage: "arrow.right")
                    .font(.headline)
                    .padding(20)
                    .frame(maxWidth: .infinity)
                    .background(Color(hex: "5f9fff"))
                    .foregroundColor(.white)
                    .cornerRadius(20, corners: [.topRight, .bottomLeft, .bottomRight])
                    .cornerRadius(8, corners: [.topLeft])
                    .shadow(color: Color(hex: "5f9fff").opacity(0.5), radius: 20, x: 0, y: 10)
            }
        }
    }
    var comfirmpassword: some View {
        VStack(alignment: .leading) {
            Text("type new password")
                .font(.subheadline)
                .foregroundColor(.secondary)
            Text(notstrongpass ? " Must have minimum 8 characters at least 1 Uppercase Alphabet, 1 Lowercase Alphabet and 1 Number" : "")
                .font(.subheadline)
                .foregroundColor(.red)
            SecureField("", text: $password)
                .customTextField(image:Image(systemName: "lock.fill"))
            Text("comfirm new password")
                .font(.subheadline)
                .foregroundColor(.secondary)
            +
            Text(shouldmatch ? " should match password" : "")
                .font(.subheadline)
                .foregroundColor(.red)
            SecureField("", text: $passwordcomfirm)
                .customTextField(image:Image(systemName: "lock.fill"))
                
            Button{
                if(password != passwordcomfirm){
                    shouldmatch = true
                } else
                if (!Vm.isValidPassword(password: password)){
                    notstrongpass = true
                } else{
                    let newmail = email.firstUppercased

                    Vm.setnewpw(email: newmail, newpw: password, completed:  { (success) in
                        if (success){
                           // comfirmpw.toggle()
                           // code.toggle()
                            forgetpw.toggle()
                            showSignIn.toggle()
                        }else{
                            unvalidcode = true
                        }
                            
                    })
                }

                
            }label: {
                Label("Enter new password", systemImage: "arrow.right")
                    .font(.headline)
                    .padding(20)
                    .frame(maxWidth: .infinity)
                    .background(Color(hex: "5f9fff"))
                    .foregroundColor(.white)
                    .cornerRadius(20, corners: [.topRight, .bottomLeft, .bottomRight])
                    .cornerRadius(8, corners: [.topLeft])
                    .shadow(color: Color(hex: "5f9fff").opacity(0.5), radius: 20, x: 0, y: 10)
            }
        }
    }
}

struct ForgetPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgetPasswordView(showSignIn: .constant(false), forgetpw: .constant(true))
    }
}
