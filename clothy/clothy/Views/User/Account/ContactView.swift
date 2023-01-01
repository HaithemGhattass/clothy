//
//  ContactView.swift
//  clothy
//
//  Created by haithem ghattas on 29/11/2022.
//

import SwiftUI

struct ContactView: View {
    @ObservedObject private var vm = UsersViewModel()
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    init(){
        vm.fetchuser()
    }

    var body: some View {
        
        Form {
               contact
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing){
                Button("Done"){
                    vm.editUser(completed: { (reponse)  in
                        reponse ? self.presentationMode.wrappedValue.dismiss() : print("error cant connect")
                    })
                }
            }
        }
        .accentColor(.primary)
        .listRowSeparatorTint(.blue)
        .listRowSeparator(.hidden)

    
}
    var contact: some View {
        Section {
            TextField(String(vm.phone), value: $vm.phone, formatter: NumberFormatter())
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
