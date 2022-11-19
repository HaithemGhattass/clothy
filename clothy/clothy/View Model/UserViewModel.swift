//
//  UserViewModel.swift
//  clothy
//
//  Created by haithem ghattas on 11/11/2022.
//

import Foundation
import Alamofire
import SwiftyJSON
import UIKit

final class UsersViewModel : ObservableObject{
    @Published var hasError = false
        @Published var error: UserError?
        
    @Published var users = [User] ()
    
    var email: String = ""
    var password: String = ""
   @Published var firstname: String = ""
    @Published var lastname: String = ""
    @Published var phone: Int = 0
    var pseudo: String = ""
    var id: String = ""
    var v: Int = 0
    var createdAt: String = ""
    var updatedAt: String = ""
    var imageF: String = ""

    var birthdate: Date = Date()
    var preference: String = ""
    var gender: String = ""
    var HOST_URL = "http://192.168.1.12:3000/"
    @Published var selectedgender: String = ""

      //var selectedgender: Gendr = .male





    
    
        @Published private(set) var isRefreshing = false
    
    func fetchuser(){
        let userstringurl = HOST_URL+"api/us"
        if let url = URL(string:userstringurl) {
            URLSession
                .shared
                .dataTask(with: url) { [weak self] data, response, error in
                                
                                    
                                    DispatchQueue.main.async {
                                        
                                        defer {
                                            self?.isRefreshing = false
                                        }
                                        
                                        if let error = error {
                                            self?.hasError = true
                                            self?.error = UserError.custom(error: error)
                                            print(error)
                                        } else {
                                            
                                            let decoder = JSONDecoder()
                                            decoder.keyDecodingStrategy = .convertFromSnakeCase // Handle properties that look like first_name > firstName
                                            print("fetshing ...")
                                         //   print(data)
                                            if let data = data,
                                               let users = try? decoder.decode([User].self, from: data) {
                                             

                                                self?.users = users
                                                self?.imageF =  users[0].imageF
                                                self?.email =  users[0].email
                                                self?.password =  users[0].password
                                                self?.firstname =  users[0].firstname
                                                self?.lastname =  users[0].lastname
                                                self?.phone =  users[0].phone
                                                self?.pseudo =  users[0].pseudo
                                                self?.id =  users[0].id
                                                
                                                self?.birthdate = DateUtils.formatFromString(string: users[0].birthdate)
                                                
                                                self?.createdAt =  users[0].createdAt
                                                self?.selectedgender =  users[0].gender
                                          //      print(self?.imageF)

//                                                if(self?.gender == "male"){
//                                                    self?.selectedgender = .male
//                                                }
//                                                else if
//                                                    (self?.gender == "female"){
//                                                    self?.selectedgender = .female
//                                                } else {
//                                                    self?.selectedgender = .other
//                                                }
                                                //ProfileView().updateselectedgender()
                                                print(data)

                                               
                                                print(self?.firstname ?? "fff")

                                            } else {
                                                self?.hasError = true
                                                self?.error = UserError.failedToDecode
                                               // print(error)
                                             //   print(self?.error)
                                            //    print(self?.hasError)
                                            }
                                        }
                                    }
                }.resume()
        }
        
    }
    func editUser(completed: @escaping (Bool) -> Void) {
       // print(utilisateur)
        AF.request(HOST_URL + "api/up/"+id,
                   method: .put,
                   parameters: [
                    
                 //   "_id" : id,
                    "pseudo": pseudo,
                    "email": email,
                    //"mdp": utilisateur.mdp!,
                    "firstname": firstname,
                    "lastname": lastname,
                    "birthdate": DateUtils.formatFromDate(date: birthdate),
                    //"idPhoto": utilisateur.idPhoto!,
                    "gender": selectedgender,
                    "phone": phone
                    //"bio": utilisateur.bio!
                   ], encoding: JSONEncoding.default)
        .validate(statusCode: 200..<300)
        .validate(contentType: ["application/json"])
        .responseData { response in
            switch response.result {
            case .success:
                print("updated..")
              
                completed(true)
            case let .failure(error):
                print(error)
                completed(false)
            }
        }
    }
    
    
    
    func changepassword(password: String , newpass: String ,completed: @escaping (Bool) -> Void) {
       // print(utilisateur)
        AF.request(HOST_URL + "api/updatepass/"+email,
                   method: .put,
                   parameters: [
                    
                 //   "_id" : id,
                    "password": password,
                    "newPassword": newpass,
                   
                   ], encoding: JSONEncoding.default)
        .validate(statusCode: 200..<300)
        .validate(contentType: ["application/json"])
        .responseData { response in
            switch response.result {
            case .success:
                print("updated..")
                print(self.email)
              
                completed(true)
            case let .failure(error):
                print(error)
                print(self.email)

                completed(false)
            }
        }
    }
    
    //MARK: UPLOAD IMAGE
    func PostVideoUrl(url : UIImage){
        // Access Shared Defaults Object
        let userDefaults = UserDefaults.standard

        // Read/Get Value
        let email = userDefaults.object(forKey: "email") as? String ?? ""


        let headers: HTTPHeaders = [
            "Content-type": "multipart/form-data"
        ]

        AF.upload(
            multipartFormData: { multipartFormData in
                multipartFormData.append(url.jpegData(compressionQuality: 0.5)!, withName: "imageF" , fileName: "imageF.jpeg", mimeType: "image/jpeg")
        },
            to: HOST_URL + "api/updateImage/"+email, method: .post , headers: headers)
            .response { resp in
                print(resp)

        }

    }
    
 // 9090/uploads (get image)
//    func getImage() {
//        AF.request(HOST_URL + "uploads/"+ imageF).responseImage { response in
//            debugPrint(response)
//
//            print(response.request)
//            print(response.response)
//            debugPrint(response.result)
//
//            if case .success(let image) = response.result {
//                print("image downloaded: \(image)")
//            }
//        }
//
//    }
    
}
extension UsersViewModel {
    enum UserError: LocalizedError {
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
extension UsersViewModel {
    enum Gendr: String, CaseIterable, Identifiable {
        case male, female, other
        var id: Self { self }
    }
}
