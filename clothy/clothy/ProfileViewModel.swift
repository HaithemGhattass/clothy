////
////  ProfileViewModel.swift
////  clothy
////
////  Created by haithem ghattas on 12/11/2022.
////
//
//import Foundation
//import SwiftUI
//final class ProfileViewModel : ObservableObject {
//   // @Published var profile: Profile = .empty
//    var isValid : Bool {
//        !profile.general.firstname.isEmpty &&
//        !profile.general.lastname.isEmpty
//    }
//    
//    
//    func updateView() {
//        self.objectWillChange.send()
//    }
//    func somtextfields(pseudo: String,firstname: String,lastname : String,ps : Binding<String>,ps2 : Binding<String>,ps3 : Binding<String>) {
//        
//        TextField(pseudo,text: ps)
//            .textContentType(.nickname)
//           
//            
//        TextField(firstname,text:ps2)
//            .textContentType(.name)
//            .keyboardType(.namePhonePad)
//            .foregroundColor(.black)
//        TextField(lastname,text: ps3)
//            .textContentType(.name)
//            .keyboardType(.namePhonePad)
//            .foregroundColor(.black)
//    }
//    
//}
