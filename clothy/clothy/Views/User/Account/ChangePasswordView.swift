//
//  ChangePasswordView.swift
//  clothy
//
//  Created by haithem ghattas on 15/11/2022.
//

import SwiftUI
struct ChangePasswordView: View {
    @ObservedObject private var vm = UsersViewModel()
    @State var mypass : String = ""
    @State var newpass : String = ""
    @State var confirmpass : String = ""
    @State private var showingAlert = false
    @State private var presentAlert = false


    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var body: some View {
        
        Form {
            Section {
                if(vm.password != ""){
                    SecureField("Enter your password",text: $mypass)
                        .textContentType(.password)
                        .keyboardType(.namePhonePad)
                }
              
                
                SecureField("Enter new password",text: $newpass)
                    .textContentType(.password)
                    .keyboardType(.namePhonePad)
                SecureField("Comfirm password",text: $confirmpass)
                    .textContentType(.password)
                    .keyboardType(.namePhonePad)
            }

        
        header: {
            Text("Password")
                .foregroundColor(.black)
        }footer: {
            Text("please enter any information")
        }
        .headerProminence(.increased)
        }
        .onAppear{
            vm.fetchuser()
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing){
                Button("Done"){
                    vm.changepassword(password: mypass, newpass: newpass, completed: {  (succ) in if (succ){
                        self.presentationMode.wrappedValue.dismiss()
                    }else {
                        presentAlert = true
                    }})
                    //action(vm.edit)
                }.disabled($newpass.wrappedValue == $confirmpass.wrappedValue ? false : true)
                    .alert("Oops ,please verify your passwod", isPresented: $presentAlert) {
                        Button("OK", role: .cancel) { }
                    }
            }
        }
        .accentColor(.primary)
        .listRowSeparatorTint(.blue)
        .listRowSeparator(.hidden)
    }
}

struct ChangePasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ChangePasswordView()
    }
}
