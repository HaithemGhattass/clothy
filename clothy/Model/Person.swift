//
//  Person.swift
//  clothy
//
//  Created by Mohamed Amine Mtar on 11/11/2022.
//
import Alamofire
import SwiftyJSON
import Foundation
struct Person: Codable {
    let id, firstname, lastname, pseudo: String
    let email, password, preference, createdAt: String
    let updatedAt: String
    let v: Int
    static let allPeople: [Person] = Bundle.main.decode(file: "http://192.168.1.5:9090/api/us")
        static let samplePerson: Person = allPeople[0]
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case firstname, lastname, pseudo, email, password, preference, createdAt, updatedAt
        case v = "__v"
    }
    
}

extension Bundle {
    func decode<T: Decodable>(file: String) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Could not find \(file) in bundle.")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Could not load \(file) from bundle.")
        }
        
        let decoder = JSONDecoder()
        
        guard let loadedData = try? decoder.decode(T.self, from: data) else {
            fatalError("Could not decode \(file) from bundle.")
        }
        
        return loadedData
    }
}
