//
//  user.swift
//  clothy
//
//  Created by haithem ghattas on 8/11/2022.
//

import Foundation

struct User: Codable {
    let firstname, lastname, birthdate, pseudo: String
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
}
