//
//  Message.swift
//  clothy
//
//  Created by haithem ghattas on 4/12/2022.
//

import Foundation

struct Message: Identifiable, Codable {
    var id: String
    var text: String
    var from: String
    var timestamp: Date
}
struct Room: Identifiable , Codable {
    var id: String
    var reciver: String
    var sender: String
}
struct ChatRooms: Identifiable , Codable {
    var id: String
    var reciver: String
    var sender: String
}
struct Messaging: Identifiable, Codable {
    var id: String
    var from: String
    var to: String
    var text: String
    var timestamp: Date
}
