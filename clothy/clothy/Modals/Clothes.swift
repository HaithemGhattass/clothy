//
//  Clothes.swift
//  clothy
//
//  Created by haithem ghattas on 18/11/2022.
//

import Foundation


struct Clothes: Codable {
    let typee, couleur, photo, category, userID: String
    let taille, id, createdAt: String
    let updatedAt: String
    let v: Int

    enum CodingKeys: String, CodingKey {
        case typee, couleur, photo, userID, taille
        case id = "_id"
        case createdAt, updatedAt , category
        case v = "__v"
    }
}
