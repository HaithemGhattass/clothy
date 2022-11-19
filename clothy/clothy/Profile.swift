////
////  Profile.swift
////  clothy
////
////  Created by haithem ghattas on 12/11/2022.
////
//
//import Foundation
//
////let x: Profile.General = .init(pseudo: "", firstname: "", lastname: "")
//
//struct Profile {
//    
//    var general : General
//    var contact : Contact
//    
//}
//
//extension Profile {
//    struct Contact {
//        var phone: String
//        var email : String
//        
//        
//    }
//}
//
//extension Profile {
//    struct General {
//        var pseudo: String
//        var firstname : String
//        var lastname : String
//        var gender : Gender
//        
//    }
//}
//extension Profile.General {
//    enum Gender: String, Identifiable, CaseIterable {
//        var id: Self {self}
//        case male
//        case female
//        case na = "prefer not to say"
//    }
//}
//extension Profile  {
//    static var empty: Profile {
//        let general = Profile.General(pseudo: "", firstname: "", lastname: "", gender: Profile.General.Gender.allCases.first!)
//        let contact = Profile.Contact(phone: "", email: "")
//        return Profile(general: general, contact: contact)
//    }
//}
//
