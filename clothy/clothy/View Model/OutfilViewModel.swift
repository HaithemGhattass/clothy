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
    
    var vm = UsersViewModel()
    @Published var hasError = false
    @Published var error: ClothesError?
    @Published private(set) var isRefreshing = false
    @Published var clothes = [Clothes] ()
    @Published var tickets = [TicketModel] ()
    
    @Published var type: String = ""
    @Published var taille: String = ""
    @Published var couleur: String = ""
    @Published var description: String = ""
    @Published var userID: String = ""
    @Published var photo: String = ""
    //
    //    func addOutfit( completed: @escaping (Bool) -> Void) {
    //        let headers: HTTPHeaders = [
    //            "Content-type": "multipart/form-data"
    //        ]
    //        AF.request(vm.HOST_URL+"/outfit/addOutfit",
    //                   method: .post,
    //                   parameters: [
    //                    "typee": type,
    //                    "taille": taille,
    //                    "couleur": couleur,
    //                    "description":description,
    //                    "userID":  UserDefaults.standard.integer(forKey: "userID"),
    //                    "photo": photo
    //
    //                   ] ,encoding: JSONEncoding.default)
    //        .validate(statusCode: 200..<300)
    //        .validate(contentType: ["application/json"])
    //        .responseData { response in
    //            switch response.result {
    //            case .success:
    //                print("Validation Successful")
    //                completed(true)
    //
    //            case let .failure(error):
    //                print(error)
    //                completed(false)
    //            }
    //        }
    //
    //   }
    func PostImage(url : UIImage ,type: String, completed: @escaping (Bool) -> Void) {
        
        let headerS: HTTPHeaders = [
            "Content-type": "multipart/form-data"
        ]
        let parameterS: Parameters = [   "typee": type,
                                         "taille": "taille",
                                         "couleur": "couleur",
                                         "description":"description",
                                         "userID":  UserDefaults.standard.string(forKey: "userID") ?? ""
                                         
        ]
        // print(UserDefaults.standard.string(forKey: "userID"))
        
        
        
        AF.upload(
            multipartFormData: { multipartFormData in
                for (key, value) in parameterS {
                    if let temp = value as? String {
                        multipartFormData.append(temp.data(using: .utf8)!, withName: key)
                    }
                    
                    
                }
                multipartFormData.append(url.jpegData(compressionQuality: 0.5)!, withName: "photo" , fileName: "photo.jpeg", mimeType: "image/jpeg")
            },
            to: vm.HOST_URL+"outfit/addOutfit", method: .post , headers: headerS)
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
    
    func getClothes(categorie: String){
        // let userid = UserDefaults.standard.integer(forKey: "userID")
       
        let clothesURL = vm.HOST_URL+"outfit/OFT/"+categorie
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
                                
                                
                                print(data)
                                print("aaaaaaaaaaaaa")
                            } else {
                                self?.hasError = true
                                self?.error = ClothesError.failedToDecode
                                // print(error)
                                //   print(self?.error)
                                //    print(self?.hasError)
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
