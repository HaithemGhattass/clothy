//
//  LoginViewModal.swift
//  clothy
//
//  Created by haithem ghattas on 7/11/2022.
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
      
        AF.request("http://localhost:9090/api/login",
                   method: .post,
                   parameters: ["email": email, "password": password], encoding: JSONEncoding.default)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                   
                case .success:
                    let jsonData = JSON(response.data!)
                    print(jsonData)
                    let utilisateur = self.makeItem(jsonItem: jsonData["userr"])
                    UserDefaults.standard.setValue(jsonData["token"].stringValue, forKey: "tokenConnexion")
                    UserDefaults.standard.setValue(utilisateur._id, forKey: "id")
                    print(utilisateur)
                    
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
           defaults.removeObject(forKey: "jsonwebtoken")
           DispatchQueue.main.async {
               self.isAuthenticated = false
           }
           
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
    
    
    
    func makeItem(jsonItem: JSON) -> User {
        
   

        
        return User(
            _id: jsonItem["_id"].stringValue,
            pseudo: jsonItem["pseudo"].stringValue,
            email: jsonItem["email"].stringValue,
            password: jsonItem["password"].stringValue,
            firstname: jsonItem["firstname"].stringValue,
            lastname: jsonItem["lastname"].stringValue,
            birthdate: DateUtils.formatFromString(string: jsonItem["dateNaissance"].stringValue)
         //   idPhoto: jsonItem["idPhoto"].stringValue,
          //  sexe: jsonItem["sexe"].boolValue,
         //   score: jsonItem["score"].intValue,
         //   bio: jsonItem["bio"].stringValue,
        //    isVerified: jsonItem["isVerified"].boolValue,
          
        )
    }
  
    
}

