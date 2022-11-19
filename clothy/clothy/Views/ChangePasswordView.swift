//
//  ChangePasswordView.swift
//  clothy
//
//  Created by haithem ghattas on 15/11/2022.
//

import SwiftUI
import FormValidator

struct ChangePasswordView: View {
    @StateObject private var vm = UsersViewModel()
    @State var mypass : String = ""
    @State var newpass : String = ""
    @State var confirmpass : String = ""
    @ObservedObject var formInfo = FormInfo()
    @State private var showingAlert = false
    @State private var presentAlert = false


    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var body: some View {
       ZStack {
            Color("Background").ignoresSafeArea()
        
        NavigationView {
          
            Form {
                Section {
                    // 6
                  
                    
                    SecureField("Enter your password",text: $mypass)
                        .textContentType(.password)
                        .keyboardType(.namePhonePad)

                    SecureField("Enter new password",text: $formInfo.newpass)
                        .textContentType(.password)
                        .keyboardType(.namePhonePad)
                        .validation(formInfo.newpassValidation)

                    
                    SecureField("Comfirm password",text: $formInfo.comfirmpass)
                        .textContentType(.password)
                        .keyboardType(.namePhonePad)
                        .validation(formInfo.comfirmpassValidation)
                    

                      
                    
                    

                  
                    
                    
            
                    
                    
                    
                }
                
                
                
            header: {
                Text("General")
                    .foregroundColor(.black)
                
                
            }footer: {
                Text("please enter any information")
            }
            .headerProminence(.increased)
                
                
                
                  
                
            }
            .onAppear(perform: vm.fetchuser)
            
          
            
           
         
          
          
            .navigationTitle("Edit Password")
            .toolbar {
                ToolbarItem(placement: .keyboard){
                    Button("Done"){
                        vm.changepassword(password: mypass, newpass: formInfo.newpass, completed: {  (succ) in if (succ){
                            print("succ")
                            self.presentationMode.wrappedValue.dismiss()
                        }else {
                           presentAlert = true
                        }})
                        //action(vm.edit)
                    }.disabled($newpass.wrappedValue == $confirmpass.wrappedValue ? false : true)
                        .alert("Oops ,please verify your passwod", isPresented: $presentAlert) {
                                    Button("OK", role: .cancel) { }
                                }

                  //  .disabled(!vmp.isValid)
                }
            }
            
         
        
                    
                
                //    if(newpass == confirmpass && !newpass.isEmpty) {
                        
                    
//                        loginVM.connexion(completed: { (reponse,user)  in
//
//                            if (reponse) {
//
//                                //User() = reponse
//                              //  let utilisateur = reponse as! User
//
//
//                                logIn()
//
//
//                            } else {
//                                print("ERROR CANT CONNECT")
//                            }
//
//                        })
                      
                        
                
                
            

         
        }

        

        .navigationBarBackButtonHidden(true)
       

        }
    }
    
}

struct ChangePasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ChangePasswordView()
    }
}
