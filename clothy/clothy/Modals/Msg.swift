//
//  Msg.swift
//  clothy
//
//  Created by haithem ghattas on 13/12/2022.
//

import Foundation
// MARK: - Msg
struct Msg: Codable {
    let to, id, matchID: String
    let v: Int
    let from, message, updatedAt, createdAt: String

    enum CodingKeys: String, CodingKey {
        case to
        case id = "_id"
        case matchID
        case v = "__v"
        case from, message, updatedAt, createdAt
    }
}

//typealias MsgElement = [Msg]
