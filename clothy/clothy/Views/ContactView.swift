//
//  ContactView.swift
//  clothy
//
//  Created by haithem ghattas on 29/11/2022.
//

import SwiftUI

struct ContactView: View {
    @StateObject private var vm = UsersViewModel()
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var body: some View {
        
        Form {
            
          
           
               contact

            
        }
      

        .onAppear{
                vm.fetchuser()
          
        }
        
 
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing){
                Button("Done"){
                    vm.editUser(completed: { (reponse)  in
                        
                        if (reponse) {
                          //  trah = true
                            //vmp.updateView()
                           // vm.fetchuser()
                            
                            print($vm.firstname)
                            //User() = reponse
                          //  let utilisateur = reponse as! User
                            print("normalement jawk behy")
                        //    logIn()
                            
                            self.presentationMode.wrappedValue.dismiss()

                        } else {
                            print("ERROR CANT CONNECT")
                        }
                        
                    })
                    //action(vm.edit)
                }
              //  .disabled(!vmp.isValid)
            }
        }
        .accentColor(.primary)
        .listRowSeparatorTint(.blue)
        .listRowSeparator(.hidden)
     
    
   

    
    
}
    var contact: some View {
        Section {
            TextField(String(vm.phone), value: $vm.phone, formatter: NumberFormatter())
            
            //  TextField(vm.phone,value:$vm.phone,formatter: NumberFormatter())
                .textContentType(.telephoneNumber)
                .keyboardType(.phonePad)
            TextField(vm.email,text:$vm.email)
                .textContentType(.emailAddress)
                .keyboardType(.emailAddress)
            
            
        }header: {
            Text("Contact")
                .foregroundColor(.black)
            
            
        }footer: {
            Text("please enter your contact informations")
        }
        .headerProminence(.increased)
    }
}

struct ContactView_Previews: PreviewProvider {
    static var previews: some View {
        ContactView()
    }
}
