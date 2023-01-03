//
//  SignUpView.swift
//  ClothyApp
//
//  Created by haithem ghattas on 17/12/2022.
//

import SwiftUI

struct SignUpView: View {
    @Binding var showSignUp : Bool
    @Binding var showSignIn : Bool
    @StateObject private var Vm = UsersViewModel()
    @State var pseudo : String = ""
    @State var lastname : String = ""
    @State var firstname : String = ""
    @State var email : String = ""
    @State var phone : String = ""
    @State var password : String = ""
    @State var comfirmpassword : String = ""
    @State var gender : String = "Male"
    @State var birthdate :Date = Date()
    @State var options = ["Male", "Female", "Other"]
    @State var general = true
    @State var details = false
    @State var comfirmingpw = ""
    @State var comfirmingpw2 = ""
    @State var phoneerr = ""
    @State var wronngemail = false
    @State var wrongfirstname = false
    @State var wronglastname = false
    @State var wrongpseudo = false


    var body: some View {

            VStack(spacing: 24) {
                Text("Sign Up")
                    .font(.largeTitle).bold()
                  
                    Link(" by signing up you automaticly accept Clothy Terms of service and conditions", destination: URL(string: HostUtils().HOST_URL + "term")!)
                    .font(.caption).bold()
                
     
                if general{
                    generalinfo
                }
                if details {
                    detailedinfo
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
    var generalinfo: some View {
        VStack(alignment: .leading) {
            Text("Pseudo")
                .font(.subheadline)
                .foregroundColor(.secondary)
            + Text(wrongpseudo ? " please enter a valid Pseudo" : "")
                .font(.subheadline)
                .foregroundColor(.red)
            TextField("", text: $pseudo)
                .customTextField(image: Image(systemName: "person.circle"))

            Text("First Name")
                .font(.subheadline)
                .foregroundColor(.secondary)
            + Text(wrongfirstname ? " please enter a valid First Name" : "")
                .font(.subheadline)
                .foregroundColor(.red)
            TextField("", text: $firstname)
                .customTextField(image: Image(systemName: "person.circle"))
            Text("Last Name")
                .font(.subheadline)
                .foregroundColor(.secondary)
            + Text(wronglastname ? " please enter a valid Last Name" : "")
                .font(.subheadline)
                .foregroundColor(.red)
            TextField("", text: $lastname)
                .customTextField(image: Image(systemName: "person.circle"))
            Text("Email ")
                .font(.subheadline)
                .foregroundColor(.secondary)
            + Text(wronngemail ? " please enter a valid mail" : "")
                .font(.subheadline)
                .foregroundColor(.red)

            TextField("", text: $email)
                .customTextField()
            Button{
                Vm.textFieldValidatorEmail(pseudo: pseudo, lastname: lastname, firstname: firstname, email: email, completed: { (status,err) in

                    if !status{
                         if (err == 0 ){
                            wronngemail = true
                         } else {
                             wronngemail = false
                         }
                         if (err == 1){
                            wrongfirstname  = true
                         }else{
                             wrongfirstname  = false

                         }
                         if (err == 2){
                            wronglastname  = true
                         }else {
                             wronglastname  = false
                         }
                         if (err == 3){
                            wrongpseudo  = true
                         }else{
                             wrongpseudo  = false
                         }
                    } else {
                        general.toggle()
                        details.toggle()
                    }
                })
            
                  
                 
                    
                 
               
            }label: {
                Label("Next", systemImage: "arrow.right")
                    .font(.headline)
                    .padding(20)
                    .frame(maxWidth: .infinity)
                    .background(Color(hex: "5f9fff"))
                    .foregroundColor(.white)
                    .cornerRadius(20, corners: [.topRight, .bottomLeft, .bottomRight])
                    .cornerRadius(8, corners: [.topLeft])
                .shadow(color: Color(hex: "5f9fff").opacity(0.5), radius: 20, x: 0, y: 10)
            }

//                    Text("Password")
//                        .font(.subheadline)
//                        .foregroundColor(.secondary)
//                    SecureField("", text: $password)
//                        .customTextField(image: Image(systemName: "lock"))
//                    Text("comfirm Password")
//                        .font(.subheadline)
//                        .foregroundColor(.secondary)
//                    SecureField("", text: $comfirmpassword)
//                        .customTextField(image: Image(systemName: "lock"))
            
        }
    }
    var detailedinfo: some View {
        VStack(alignment: .leading) {
            Text("phone number")
                .font(.subheadline)
                .foregroundColor(.secondary)
            + Text(phoneerr).foregroundColor(.red).font(.subheadline)
            TextField("", text: $phone)
                .customTextField(image: Image(systemName: "phone.circle"))
                .keyboardType(.numberPad)
            Text("Password " )
                .font(.subheadline)
                .foregroundColor(.secondary)
            + Text(comfirmingpw).foregroundColor(.red).font(.subheadline)
            SecureField("", text: $password)
                .customTextField(image: Image(systemName: "lock"))
            Text("comfirm Password ")
                .font(.subheadline)
                .foregroundColor(.secondary)
            + Text(comfirmingpw2).foregroundColor(.red).font(.subheadline)
            SecureField("", text: $comfirmpassword)
                .customTextField(image: Image(systemName: "lock"))
            DatePicker("Birthdate", selection:$birthdate,in: ...Date(),displayedComponents: [.date])
                .datePickerStyle(.automatic)
                .accentColor(Color(hex: "5f9fff"))
                .font(.subheadline)
                .foregroundColor(.secondary)
                .padding(15)
            Text("Gender")
                .font(.subheadline)
                .foregroundColor(.secondary)
            
                .padding(.leading, 10)
            Picker("", selection: $gender) { // 3
                ForEach(options, id: \.self) { item in // 4
                    Text(item) // 5
                }
            }
            .pickerStyle(.segmented)
            .foregroundColor(.secondary)
            .accentColor(Color(hex: "5f9fff"))
            .padding(15)

            HStack{
                Button{

                    details.toggle()
                    general.toggle()
                }label: {
                    Label("Back", systemImage: "arrow.left")
                        .font(.headline)
                        .padding(20)
                        .frame(maxWidth: .infinity)
                        .background(Color(hex: "5f9fff"))
                        .foregroundColor(.white)
                        .cornerRadius(20, corners: [.topRight, .bottomLeft, .bottomRight])
                        .cornerRadius(8, corners: [.topLeft])
                    .shadow(color: Color(hex: "5f9fff").opacity(0.5), radius: 20, x: 0, y: 10)
                }
                Button{
                    if(phone.count < 8){
                        phoneerr = "phone number must have at least 8 degits"
                    } else
                    if(password.count < 5){
                        comfirmingpw = "should have at least 5 characters"
                        comfirmingpw2 = "should have at least 5 characters"
                    }
                    else if(password != comfirmpassword){
                        comfirmingpw = "and comfirm password should be identic"
                        comfirmingpw2 = "and password should be identic"
                    }
                   else{
                       let user = User(firstname: firstname, lastname: lastname, pseudo: pseudo, birthdate: DateUtils.formatFromDate(date: birthdate), imageF: "", email: email, password: password, preference: "password", gender: gender, id: "", createdAt: "", updatedAt: "", isVerified: false, phone: Int(phone) ?? 000, v: 1)
                        Vm.inscription(user: user ,completed: { (success) in
                            
                            if success {
                                
                                withAnimation{
                                    general.toggle()
                                    details.toggle()
                                    showSignUp.toggle()
                                    showSignIn.toggle()
                                }
                                
                                
                            } else {
                                print("fama mochkla ")
                                
                                
                            }
                            
                        })
                    }

                }label: {
                    Label("sign Up", systemImage: "arrow.right")
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
    
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView(showSignUp: .constant(true), showSignIn: .constant(false))
    }
}
