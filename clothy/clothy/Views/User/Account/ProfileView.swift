//
//  ProfileView.swift
//  ClothyApp
//
//  Created by haithem ghattas on 20/12/2022.
//

import SwiftUI

struct ProfileView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var pseudo : String = ""
    @State var firstname : String = ""
    @State var lastname : String = ""
    @State private var changepass = false
    @State var options = ["Male", "Female", "Other"]
    @ObservedObject private var Vm = UsersViewModel()
    init(){
        Vm.fetchuser()
    }
    var body: some View {
        Form {
                general
            
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing){
                Button("Done"){
                    Vm.editUser(completed: { (reponse)  in

                        if (reponse) {
                          
                            self.presentationMode.wrappedValue.dismiss()
                                
                            
                        } else {
                            print("ERROR CANT CONNECT")
                        }

                    })
                   
                }
               
            }
        
        }
        .accentColor(.primary)
        .listRowSeparatorTint(.blue)
        .listRowSeparator(.hidden)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}


private extension ProfileView {
    var general: some View {
        Section {

            
            TextField(Vm.pseudo,text: $Vm.pseudo)
               .textContentType(.nickname)
            
            
            TextField(Vm.firstname ,text: $Vm.firstname)
                .textContentType(.name)
                .keyboardType(.namePhonePad)
            // .foregroundColor(.black).refreshable (action: vm.fetchuser)
            TextField(Vm.lastname,text: $Vm.lastname)
                .textContentType(.name)
                .keyboardType(.namePhonePad)
                .foregroundColor(.black)
            
            //MARK: birthdate
            DatePicker("Birthdate", selection: $Vm.birthdate,in: ...Date(),displayedComponents: [.date])
                .datePickerStyle(.automatic)
                .accentColor(Color(hex: "5f9fff"))
                .font(.subheadline)
                .foregroundColor(.secondary)
                .padding(15)
            
            //MARK: prefrences
            
            
            
            Picker("Gender", selection: $Vm.selectedgender) { // 3
                ForEach(options, id: \.self) { item in // 4
                    Text(item) // 5
                        
                }
                
            }
            .pickerStyle(.automatic)
            .foregroundColor(.secondary)
            .accentColor(Color(hex: "5f9fff"))
            .padding(15)
            
            
            
        }
        
        
    header: {
        Text("General")
            .foregroundColor(.black)
        
        
    }footer: {
        Text("please enter your information")
    }
    .headerProminence(.increased)
        
 

        
        
        
        
    }
    var contact: some View {
        Section {
//            TextField(String(user.phone), value: $user.phone, formatter: NumberFormatter())
//
//            //  TextField(vm.phone,value:$vm.phone,formatter: NumberFormatter())
//                .textContentType(.telephoneNumber)
//                .keyboardType(.phonePad)
//            TextField(user.email,text:$user.email)
//                .textContentType(.emailAddress)
//                .keyboardType(.emailAddress)
//
            
        }header: {
            Text("Contact")
                .foregroundColor(.black)
            
            
        }footer: {
            Text("please enter your contact informations")
        }
        .headerProminence(.increased)
    }

    var clearAll: some View {
        Button(role: .destructive) {
            
        }label: {
            Text("Delete Account")
        }
    }
    //MARK: EDIT PREFS
//    var gotopref: some View {
//
//        NavigationLink( "Edit Prefrences"
//                        , destination: PrefrencesView())
//
//
//
//
//    }
    var password: some View {
        Section {
//            SecureField(vm.password,text: $vm.password)
//                .textContentType(.password)
//                .keyboardType(.namePhonePad)
//
            
            
        }header: {
            
            
        }footer: {
            Text("please enter any information")
        }
        .headerProminence(.increased)
    }
 
  

}
