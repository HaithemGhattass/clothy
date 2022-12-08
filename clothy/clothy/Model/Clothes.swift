//
//  Clothes.swift
//  clothy
//
//  Created by haithem ghattas on 18/11/2022.
//

import Foundation

//enum Category : String , CaseIterable , Identifiable{
//    var id : String {self.rawValue}
//case Jeans = "Jeans"
//case Shirts = "Shirts"
//case Sneakers = "Sneakers"
//case Skirts = "Skirts"
//
//
//
//}

struct Clothes: Codable {
    let typee, couleur, photo, userID: String
    let taille, description, id, createdAt: String
    let updatedAt: String
    let v: Int

    enum CodingKeys: String, CodingKey {
        case typee, couleur, photo, userID, taille
        case description = "description"
        case id = "_id"
        case createdAt, updatedAt
        case v = "__v"
    }
}


//struct Clothes : Identifiable {
//    let id = UUID()
//    let name: String
//    let image: String
//    let description : String
//    let color : String
//    let category : Categorie.RawValue
//    let dateadded : String
//}

//extension Clothes {
//    static let all: [Clothes] = [
//        Clothes(name: "maryoul", image: "https://static.zara.net/photos///2022/V/0/1/p/4424/154/512/2/w/1126/4424154512_6_1_1.jpg?ts=1651052020605", description: "maroul men zara", color: "ahmer", category: "Outwear", dateadded: "2022-11-11") ,
//        Clothes(name: "maryoul", image: "https://static.zara.net/photos///2022/V/0/1/p/4424/154/512/2/w/1126/4424154512_6_1_1.jpg?ts=1651052020605", description: "maroul men zara", color: "ahmer", category: "Outwear", dateadded: "2022-11-11") ,
//        Clothes(name: "maryoul", image: "https://static.zara.net/photos///2022/V/0/1/p/4424/154/512/2/w/1126/4424154512_6_1_1.jpg?ts=1651052020605", description: "maroul men zara", color: "ahmer", category: "Outwear", dateadded: "2022-11-11") ,
//        Clothes(name: "maryoul", image: "https://static.zara.net/photos///2022/V/0/1/p/4424/154/512/2/w/1126/4424154512_6_1_1.jpg?ts=1651052020605", description: "maroul men zara", color: "ahmer", category: "Outwear", dateadded: "2022-11-11") ,
//        Clothes(name: "maryoul", image: "https://static.zara.net/photos///2022/V/0/1/p/4424/154/512/2/w/1126/4424154512_6_1_1.jpg?ts=1651052020605", description: "maroul men zara", color: "ahmer", category: "Outwear", dateadded: "2022-11-11") ,
//        Clothes(name: "maryoul", image: "https://static.zara.net/photos///2022/V/0/1/p/4424/154/512/2/w/1126/4424154512_6_1_1.jpg?ts=1651052020605", description: "maroul men zara", color: "ahmer", category: "Outwear", dateadded: "2022-11-11")
//
//    ]
//}
