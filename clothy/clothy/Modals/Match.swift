//
//  Match.swift
//  clothy
//
//  Created by haithem ghattas on 11/12/2022.
//

import Foundation
struct Match: Codable {
    let id, idSession, idReciver: String
    let idOutfit: [String]
    let idOutfitR: [String]
    let createdAt, updatedAt: String
    let v: Int

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case idSession = "IdSession"
        case idReciver = "IdReciver"
        case idOutfit = "IdOutfit"
        case idOutfitR = "IdOutfitR"
        case createdAt, updatedAt
        case v = "__v"
    }

}
