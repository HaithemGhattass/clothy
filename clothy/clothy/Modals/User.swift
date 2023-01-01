//
//  User.swift
//  ClothyApp
//
//  Created by haithem ghattas on 17/12/2022.
//

import Foundation

struct User: Codable {
    let firstname, lastname, pseudo: String
    let birthdate : String
    let imageF, email: String
    let phone: Int
    let password: String
    let isVerified: Bool
    let preference: String
    let gender, id, createdAt, updatedAt: String
    let v: Int

    enum CodingKeys: String, CodingKey {
        case firstname, lastname, birthdate, pseudo, imageF, email, phone, password, isVerified, preference, gender
        case id = "_id"
        case createdAt, updatedAt
        case v = "__v"
    }
    init(
        firstname : String,
        lastname : String,
        pseudo : String ,
        birthdate : String ,
        imageF : String ,
        email : String,
        password : String,
        preference : String ,
        gender : String ,
        id : String,
        createdAt : String ,
        updatedAt : String ,
        isVerified : Bool,
        phone : Int,
        v: Int
       
      
    ) {
        self.firstname = firstname
        self.lastname = lastname
        self.pseudo = lastname
        self.birthdate = birthdate
        self.imageF = imageF
        self.email = email
        self.password = password
        self.preference = preference
        self.gender = gender
        self.id = id
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.isVerified = isVerified
        self.phone = phone
        self.v = v
        
    }


}
