//
//  OutfilViewModel.swift
//  clothy
//
//  Created by haithem ghattas on 23/11/2022.
//

import Foundation
import Alamofire
import SwiftyJSON
import UIKit

final class OutfitViewModel : ObservableObject{
    
  
    @Published var hasError = false
    @Published var error: ClothesError?
    @Published private(set) var isRefreshing = false
    @Published var clothes = [Clothes] ()
   // @Published var tickets = [TicketModel] ()
    
    @Published var type: String = ""
    @Published var taille: String = ""
    @Published var couleur: String = ""
    @Published var description: String = ""
    @Published var userID: String = ""
    @Published var photo: String = ""
   
 
    func PostImage(url : UIImage ,type: String,category: String ,taille: String,color: String) {
        
        let headerS: HTTPHeaders = [
            "Content-type": "multipart/form-data"
        ]
        let parameterS: Parameters = [   "typee": category,
                                         "taille": taille,
                                         "couleur": color,
                                         "category": type
        ]
        
        AF.upload(
            multipartFormData: { multipartFormData in
                for (key, value) in parameterS {
                    if let temp = value as? String {
                        multipartFormData.append(temp.data(using: .utf8)!, withName: key)
                    }
                    
                    
                }
                multipartFormData.append(url.jpegData(compressionQuality: 0.5)!, withName: "photo" , fileName: "photo.jpeg", mimeType: "image/jpeg")
            },
            to: HostUtils().HOST_URL+"outfit/addOutfit", method: .post , headers: headerS)
        .validate(statusCode: 200..<300)
        .response { resp in
            switch resp.result{
            case .failure(let error):
                print(error)
            case.success( _):
                print("🥶🥶Response after upload Img: (resp.result)")
            }
        }
        
        
        
    }
    func trade(idroom: String,totrade:String,totradeR:String){
        AF.request(HostUtils().HOST_URL+"match/trade/"+idroom,
                   method: .post,
                   parameters: ["totrade": totrade, "totradeR": totradeR], encoding: JSONEncoding.default)
        .validate(statusCode: 200..<300)
        .validate(contentType: ["application/json"])
        
        .responseData {response in
            switch response.result {
                
            case .success:
               print("done")

              
            case .failure:
              print("fail")
            }
        }
    }
    func matchoutfitR(matchid: String){
        let clothesURL = HostUtils().HOST_URL+"match/matchoutfitR/"+matchid
        if let url = URL(string:clothesURL) {
            URLSession
                .shared
                .dataTask(with: url) { [weak self] data, response, error in
                    
                    
                    DispatchQueue.main.async {
                        
                        defer {
                            self?.isRefreshing = false
                        }
                        
                        if let error = error {
                            self?.hasError = true
                            self?.error = ClothesError.custom(error: error)
                            print(error)
                        } else {
                            
                            let decoder = JSONDecoder()
                            decoder.keyDecodingStrategy = .convertFromSnakeCase // Handle properties that look like first_name > firstName
                            print("fetshing ...")
                            
                            if let data = data,
                               let clothes = try? decoder.decode([Clothes].self, from: data) {
                                
                                
                                self?.clothes = clothes
                              print(clothes)
                            } else {
                                self?.hasError = true
                                self?.error = ClothesError.failedToDecode
                                print(error ?? "there's an error")
                             
                            }
                        }
                    }
                }.resume()
        }
        
    }
    func matchoutfit(matchid: String){
        let clothesURL = HostUtils().HOST_URL+"match/matchoutfit/"+matchid
        if let url = URL(string:clothesURL) {
            URLSession
                .shared
                .dataTask(with: url) { [weak self] data, response, error in
                    
                    
                    DispatchQueue.main.async {
                        
                        defer {
                            self?.isRefreshing = false
                        }
                        
                        if let error = error {
                            self?.hasError = true
                            self?.error = ClothesError.custom(error: error)
                            print(error)
                        } else {
                            
                            let decoder = JSONDecoder()
                            decoder.keyDecodingStrategy = .convertFromSnakeCase // Handle properties that look like first_name > firstName
                            print("fetshing ...")
                            
                            if let data = data,
                               let clothes = try? decoder.decode([Clothes].self, from: data) {
                                
                                
                                self?.clothes = clothes
                              print(clothes)
                            } else {
                                self?.hasError = true
                                self?.error = ClothesError.failedToDecode
                                print(error ?? "there's an error")
                             
                            }
                        }
                    }
                }.resume()
        }
        
    }
    
    func getClothes(categorie: String){
        let clothesURL = HostUtils().HOST_URL+"outfit/OFT/"+categorie
        if let url = URL(string:clothesURL) {
            URLSession
                .shared
                .dataTask(with: url) { [weak self] data, response, error in
                    
                    
                    DispatchQueue.main.async {
                        
                        defer {
                            self?.isRefreshing = false
                        }
                        
                        if let error = error {
                            self?.hasError = true
                            self?.error = ClothesError.custom(error: error)
                            print(error)
                        } else {
                            
                            let decoder = JSONDecoder()
                            decoder.keyDecodingStrategy = .convertFromSnakeCase // Handle properties that look like first_name > firstName
                            print("fetshing ...")
                            
                            if let data = data,
                               let clothes = try? decoder.decode([Clothes].self, from: data) {
                                
                                
                                self?.clothes = clothes
                              
                            } else {
                                self?.hasError = true
                                self?.error = ClothesError.failedToDecode
                                print(error ?? "there's an error")
                             
                            }
                        }
                    }
                }.resume()
        }
        
    }
}

extension OutfitViewModel {
    enum ClothesError: LocalizedError {
        case custom(error: Error)
        case failedToDecode
        
        var errorDescription: String? {
            switch self {
            case .failedToDecode:
                return "Failed to decode response"
            case .custom(let error):
                return error.localizedDescription
            }
        }
    }
}
