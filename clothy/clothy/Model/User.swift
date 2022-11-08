//
//  user.swift
//  clothy
//
//  Created by haithem ghattas on 8/11/2022.
//

import Foundation

struct User {
    
    internal init(_id: String? = nil, pseudo: String? = nil, email: String? = nil, password: String? = nil, firstname: String? = nil, lastname: String? = nil, birthdate: Date? = nil, idpicture: String? = nil, sexe: Bool? = nil,isVerified: Bool? = nil) {
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
      
    }
    
    var _id : String?
    var pseudo : String?
    var email : String?
    var password  : String?
    var firstname : String?
    var lastname : String?
    var birthdate : Date?
    var idpicture : String?
    var sexe : Bool?
    var isVerified : Bool?
    
 
}
