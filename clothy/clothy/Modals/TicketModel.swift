//
//  TicketModel.swift
//  clothy
//
//  Created by Mohamed Amine Mtar on 29/11/2022.
//
import SwiftUI
struct TicketModel: Identifiable,Codable {
    let typee, couleur, photo, userID: String
    let taille, id, createdAt: String
    let updatedAt: String
    let v: Int
    var idd = UUID().uuidString
    
    enum CodingKeys: String, CodingKey {
        case typee, couleur, photo, userID, taille
        case id = "_id"
        case createdAt, updatedAt
        case v = "__v"
    }
}
