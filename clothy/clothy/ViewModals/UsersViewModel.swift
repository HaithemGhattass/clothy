//
//  UserViewModal.swift
//  ClothyApp
//
//  Created by haithem ghattas on 17/12/2022.
//

import Foundation
import Alamofire
import SwiftyJSON
import UIKit

final class UsersViewModel : ObservableObject{
    @Published var hasError = false
    @Published var error: UserError?
    @Published var user = [User]()
    @Published private(set) var isRefreshing = false
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var firstname: String = ""
    @Published var lastname: String = ""
    @Published var phone: Int = 0
    @Published var pseudo: String = ""
    @Published var id: String = ""
    @Published var v: Int = 0
    @Published var createdAt: String = ""
    @Published var updatedAt: String = ""
    @Published var imageF: String = ""
    @Published var idT: String = ""
    @Published var birthdate: Date = Date()
    @Published var preference: String = ""
    @Published var selectedgender: String = ""
    
    public func isValidPassword(password : String) -> Bool {
        let passwordRegex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)[a-zA-Z\\d]{8,}$"
        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: password)
    }
    func textFieldValidatorEmail(pseudo: String ,lastname: String ,firstname: String , email: String,completed:(Bool,Int) -> Void) {
        
        let emailFormat = "(?:[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}" + "~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\" + "x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[\\p{L}0-9](?:[a-" + "z0-9-]*[\\p{L}0-9])?\\.)+[\\p{L}0-9](?:[\\p{L}0-9-]*[\\p{L}0-9])?|\\[(?:(?:25[0-5" + "]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-" + "9][0-9]?|[\\p{L}0-9-]*[\\p{L}0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21" + "-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
        //let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        if (pseudo.count > 15 || pseudo.count < 3){
            completed (false,3)
        }
        else
        if (firstname.count > 15 || firstname.count < 3){
            completed (false,1)
        } else
        if (lastname.count > 15 || lastname.count < 3){
            completed (false,2)
        } else
        if email.count > 100 {
        
            completed (false,0)
        } else
      
        if (!emailPredicate.evaluate(with: email)){
            completed (false,0)
        }
       else {
            completed (true,9)
        }
    
      
    }

    func connexion(email: String , password: String ,completed: @escaping (Bool) -> Void)  {
        
        AF.request(HostUtils().HOST_URL+"api/login",
                   method: .post,
                   parameters: ["email": email, "password": password], encoding: JSONEncoding.default)
        .validate(statusCode: 200..<300)
        .validate(contentType: ["application/json"])
        
        .responseData {response in
            switch response.result {
                
            case .success:
                let jsonData = JSON(response.data!)
                                print(jsonData)
                                let utilisateur = self.makeItem(jsonItem: jsonData["userr"])
                                UserDefaults.standard.setValue(utilisateur.id, forKey: "session")

                completed(true)
            case .failure:
                completed(false)
            }
        }
    }
    func inscription(user: User, completed: @escaping (Bool) -> Void) {
        
        AF.request(HostUtils().HOST_URL+"api/register",
                   method: .post,
                   parameters: [
                    "email": user.email,
                    "password": user.password,
                    "firstname": user.firstname,
                    "lastname":user.lastname,
                    "phone": user.phone,
                    "pseudo": user.pseudo,
                    "gender": user.gender,
                    "preference": user.preference,
                    "birthdate": user.birthdate
                   ] ,encoding: JSONEncoding.default)
        .validate(statusCode: 200..<300)
        .validate(contentType: ["application/json"])
        .responseData { response in
            switch response.result {
            case .success:
                completed(true)
            case .failure:
                completed(false)
            }
        }
    }
    func forgotpassword(email: String, completed: @escaping (Bool) -> Void) {
        AF.request(HostUtils().HOST_URL+"api/forgetpwd",
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
    func forgotpasswordcode(email: String,code: Int , completed: @escaping (Bool) -> Void) {
        AF.request(HostUtils().HOST_URL+"api/changepwcode",
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
    func setnewpw(email: String,newpw: String , completed: @escaping (Bool) -> Void) {
        AF.request(HostUtils().HOST_URL+"api/changepass",
                   method: .put,
                   parameters: ["email": email , "newPassword": newpw ], encoding: JSONEncoding.default)
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
    func editUser(completed: @escaping (Bool) -> Void) {
       // print(utilisateur)
        AF.request(HostUtils().HOST_URL + "api/updatePR/"+id,
                   method: .put,
                   parameters: [
                    "pseudo": pseudo,
                    "email": email,
                    "firstname": firstname,
                    "lastname": lastname,
                    "birthdate": DateUtils.formatFromDate(date: birthdate),
                    "gender": selectedgender,
                    "phone": phone
                   ], encoding: JSONEncoding.default)
        .validate(statusCode: 200..<300)
        .validate(contentType: ["application/json"])
        .responseData { response in
            switch response.result {
            case .success:
                completed(true)
            case let .failure(error):
                print(error)
                completed(false)
            }
        }
    }
    func fetchuser(){
        let userstringurl = HostUtils().HOST_URL+"api/SessionUser"
        if let url = URL(string:userstringurl) {
            URLSession
                .shared
                .dataTask(with: url) { [weak self] data, response, error in
                                
                    DispatchQueue.main.async {
                        defer {
                            self?.isRefreshing = false
                        }
                        if let error = error {
                            print(error)
                        } else {
                            let decoder = JSONDecoder()
                            decoder.keyDecodingStrategy = .convertFromSnakeCase // Handle properties that look like first_name > firstName
                            if let data = data,
                               let users = try? decoder.decode([User].self, from: data) {
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
                            } else {
                                self?.hasError = true
                                self?.error = UserError.failedToDecode
                                print(error ?? "failed")
                            }
                        }
                    }
                }.resume()
        }
        
    }
    func makeItem(jsonItem: JSON) -> User {
        
        
        
        return User(
            firstname: jsonItem["firstname"].stringValue,
            lastname: jsonItem["lastname"].stringValue,
            pseudo: jsonItem["pseudo"].stringValue,
            birthdate: jsonItem["birthdate"].stringValue,
            imageF: jsonItem["imageF"].stringValue,
            email: jsonItem["email"].stringValue,
            password: jsonItem["password"].stringValue,
            preference: jsonItem["preference"].stringValue,
            gender: jsonItem["gender"].stringValue,
            id: jsonItem["_id"].stringValue,
            createdAt: jsonItem["createdAt"].stringValue,
            updatedAt: jsonItem["updatedAt"].stringValue,
            isVerified: jsonItem["isVerified"].boolValue,
            phone:jsonItem["phone"].intValue,
            v:jsonItem["__v"].intValue
            
        )
    }
    func PostVideoUrl(url : UIImage){
        // Access Shared Defaults Object
       

        // Read/Get Value
      //  let email = userDefaults.object(forKey: "email") as? String ?? ""


        let headers: HTTPHeaders = [
            "Content-type": "multipart/form-data"
        ]

        AF.upload(
            multipartFormData: { multipartFormData in
                multipartFormData.append(url.jpegData(compressionQuality: 0.5)!, withName: "imageF" , fileName: "imageF.jpeg", mimeType: "image/jpeg")
        },
            to: HostUtils().HOST_URL + "api/updateImage", method: .post , headers: headers)
            .response { resp in
                
                print(resp)
               

        }

    }
    func deleteMethod() {
                guard let url = URL(string: HostUtils().HOST_URL+"api/deleteUser/"+UserDefaults.standard.string(forKey: "session")!)  else {
                    print("Error: cannot create URL")
                    return
                }
                // Create the request
                var request = URLRequest(url: url)
                request.httpMethod = "DELETE"
                URLSession.shared.dataTask(with: request) { data, response, error in
                    guard error == nil else {
                        print("Error: error calling DELETE")
                        print(error!)
                        return
                    }
                    guard let data = data else {
                        print("Error: Did not receive data")
                        return
                    }
                    guard let response = response as? HTTPURLResponse, (200 ..< 299) ~= response.statusCode else {
                        print(url)
                        
                        print("Error: HTTP request failed")
                        return
                    }
                    do {
                        guard let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                            print("Error: Cannot convert data to JSON")
                            return
                        }
                        guard let prettyJsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted) else {
                            print("Error: Cannot convert JSON object to Pretty JSON data")
                            return
                        }
                        guard let prettyPrintedJson = String(data: prettyJsonData, encoding: .utf8) else {
                            print("Error: Could print JSON in String")
                            return
                        }
                        let defaults = UserDefaults.standard
                        //defaults.removeObject(forKey: "jsonwebtoken")
                     defaults.removeObject(forKey: "session")
                        
                        print(prettyPrintedJson)
                    } catch {
                        print("Error: Trying to convert JSON data to string")
                        return
                    }
                }.resume()
            }
        func signout() {
            AF.request(HostUtils().HOST_URL+"api/logout",
                       method: .get
                       )
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success:
                    print("code is true")
                    let defaults = UserDefaults.standard
                    //defaults.removeObject(forKey: "jsonwebtoken")
                 defaults.removeObject(forKey: "session")
                case let .failure(error):
                    print(error)
                  
                }
            }
                       
            
              
              
           }
    func changepassword(password: String , newpass: String ,completed: @escaping (Bool) -> Void) {
       // print(utilisateur)
        AF.request(HostUtils().HOST_URL + "api/updatepass",
                   method: .put,
                   parameters: [
                    "password": password,
                    "newPassword": newpass,
                   ], encoding: JSONEncoding.default)
        .validate(statusCode: 200..<300)
        .validate(contentType: ["application/json"])
        .responseData { response in
            switch response.result {
            case .success:
                completed(true)
            case let .failure(error):
                print(error)
                completed(false)
            }
        }
    }
    
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

