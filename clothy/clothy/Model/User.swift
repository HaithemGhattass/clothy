//
//  user.swift
//  clothy
//
//  Created by haithem ghattas on 8/11/2022.
//

import Foundation

struct User:  Decodable {
    
    internal init(_id: String? = nil, pseudo: String? = nil, email: String? = nil, password: String? = nil, firstname: String? = nil, lastname: String? = nil, birthdate: Date? = nil, idpicture: String? = nil, sexe: Bool? = nil,isVerified: Bool? = nil, phone: String? = nil, prefrences: String? = nil) {
        self._id = _id
        self.pseudo = pseudo
        self.email = email
        self.password = password
        self.firstname = firstname
        self.lastname = lastname
        self.birthdate = birthdate
        self.idpicture = idpicture
        self.sexe = sexe
        self.isVerified = isVerified
        self.phone = phone
        self.prefrences = prefrences


      
    }
    
    var _id : String?
    var pseudo : String?
    var email : String?
    var password  : String?
    var firstname : String?
    var phone : String?
    var prefrences : String?
    var lastname : String?
    var birthdate : Date?
    var idpicture : String?
    var sexe : Bool?
    var isVerified : Bool?
    
 
}
