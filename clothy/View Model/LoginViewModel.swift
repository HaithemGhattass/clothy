//
//  LoginViewModal.swift
//  clothy
//
//  Created by Mohamed Amine Mtar on 7/11/2022.
//

import Foundation
import Alamofire
import SwiftyJSON


class LoginViewModel: ObservableObject {
    
    var email: String = ""
    var password: String = ""
    var firstname: String = ""
    var lastname: String = ""
    var phone: String = ""
    var pseudo: String = ""
    var prefrences: String = "hiphop"
    // var  utilisateur = User()
    
    @Published var hasError = false
    
    
    
    
    
    
    @Published var isAuthenticated: Bool = false
    @Published var isAResgistred: Bool = false
    
    func inscription( completed: @escaping (Bool) -> Void) {
        AF.request("http://localhost:9090/api/register",
                   method: .post,
                   parameters: [
                    "email": email,
                    "password": password,
                    "firstname": firstname,
                    "lastname":lastname,
                    "phone": phone,
                    "pseudo": pseudo,
                    "preference": prefrences
                    //"dateNaissance": DateUtils.formatFromDate(date: utilisateur.dateNaissance!) ,
                    //"idPhoto": utilisateur.idPhoto!,
                    //"sexe": utilisateur.sexe!,
                    //"score": utilisateur.score!,
                    //"bio": utilisateur.bio!
                   ] ,encoding: JSONEncoding.default)
        .validate(statusCode: 200..<300)
        .validate(contentType: ["application/json"])
        .responseData { response in
            switch response.result {
            case .success:
                print("Validation Successful")
                completed(true)
                
            case let .failure(error):
                print(error)
                completed(false)
            }
        }
    }
    
    func connexion(completed: @escaping (Bool, Any?) -> Void)  {
        
        AF.request("http://192.168.1.5:9090/api/login",
                   method: .post,
                   parameters: ["email": email, "password": password], encoding: JSONEncoding.default)
        .validate(statusCode: 200..<300)
        .validate(contentType: ["application/json"])
        
        .responseData { [self] response in
            switch response.result {
                
            case .success:
                let jsonData = JSON(response.data!)
                print(jsonData)
                //User().pseudo = jsonData["pseudo"].stringValue
                let utilisateur = self.makeItem(jsonItem: jsonData["userr"])
                UserDefaults.standard.setValue(jsonData["token"].stringValue, forKey: "tokenConnexion")
                // UserDefaults.standard.setValue(utilisateur._id, forKey: "_id")
                //       UserDefaults.standard.setValue(self.utilisateur.firstname, forKey: "firstname")
                
                
                
                //  print(utilisateur.firstname ?? "aaz")
                
                
                self.isAuthenticated = true
                completed(true, utilisateur)
            case let .failure(error):
                debugPrint(error)
                completed(false, nil)
            }
        }
    }
    
    
    
    
    func login() {
        
        let defaults = UserDefaults.standard
        
        Webservice().login(email: email, password: password) { [self] result in
            switch result {
            case .success(let token):
                print(token)
                print(firstname)
                defaults.setValue(token, forKey: "jsonwebtoken")
                DispatchQueue.main.async {
                    self.isAuthenticated = true
                    
                    //  print(LoginResponse.firstname)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func signout() {
        
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "tokenConnexion")
        self.isAuthenticated = false
        
        
        
    }
    /*
     func register() {
     
     //  let defaults = UserDefaults.standard
     
     Webservice().register(email: email, password: password, firstname: firstname, lastname: lastname, phone: phone, pseudo: pseudo) { result in
     switch result {
     case .success:
     print("registred")
     DispatchQueue.main.async {
     self.isAResgistred = true
     
     }
     
     case .failure(let error):
     print(error.localizedDescription)
     }
     }
     }
     */
    
    func forgorPW(email: String, completed: @escaping (Bool) -> Void) {
        AF.request("http://localhost:9090/api/forgetpwd",
                   method: .post,
                   parameters: ["email": email], encoding: JSONEncoding.default)
        .validate(statusCode: 200..<300)
        .validate(contentType: ["application/json"])
        .responseData { response in
            switch response.result {
            case .success:
                print("mail is sent")
                completed(true)
            case let .failure(error):
                print(error)
                completed(false)
            }
        }
    }
    func EnterfpwCode(email: String,code: Int , completed: @escaping (Bool) -> Void) {
        AF.request("http://localhost:9090/api/changepwcode",
                   method: .post,
                   parameters: ["email": email , "code": code], encoding: JSONEncoding.default)
        .validate(statusCode: 200..<300)
        .validate(contentType: ["application/json"])
        .responseData { response in
            switch response.result {
            case .success:
                print("code is true")
                completed(true)
            case let .failure(error):
                print(error)
                completed(false)
            }
        }
    }
    
    
    
    
    
    func makeItem(jsonItem: JSON) -> User {
        
        
        
        
        return User(
            firstname: jsonItem["firstname"].stringValue,
            lastname: jsonItem["lastname"].stringValue,
            birthdate: jsonItem["birthdate"].stringValue,
            pseudo: jsonItem["pseudo"].stringValue,
            imageF: jsonItem["email"].stringValue,
            email: jsonItem["email"].stringValue,
            phone: jsonItem["phone"].intValue,
            password: jsonItem["password"].stringValue,
            isVerified: jsonItem["isVerified"].boolValue,
            preference: jsonItem["preference"].stringValue,
            gender: jsonItem["--v"].stringValue,
            id: jsonItem["_id"].stringValue,
            createdAt: jsonItem["createdAt"].stringValue,
            updatedAt:jsonItem["birthdate"].stringValue,
            v:jsonItem["imageF"].intValue
            //   idPhoto: jsonItem["idPhoto"].stringValue,
            //  sexe: jsonItem["sexe"].boolValue,
            //   score: jsonItem["score"].intValue,
            //   bio: jsonItem["bio"].stringValue,
            //    isVerified: jsonItem["isVerified"].boolValue,
            
        )
    }
    
  struct LoginViewModel {
        let user : User
        var fnmae: String {
            return self.user.firstname ?? "oppa ala ouropa"
        }
    }
    
}


