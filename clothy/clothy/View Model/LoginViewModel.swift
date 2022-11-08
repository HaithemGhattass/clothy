//
//  LoginViewModal.swift
//  clothy
//
//  Created by haithem ghattas on 7/11/2022.
//

import Foundation

class LoginViewModel: ObservableObject {
    
    var email: String = ""
    var password: String = ""
    var firstname: String = ""
    var lastname: String = ""
    var phone: String = ""
    var pseudo: String = ""




    @Published var isAuthenticated: Bool = false
    @Published var isAResgistred: Bool = false

    
    
    func login() {
        
        let defaults = UserDefaults.standard
        
        Webservice().login(email: email, password: password) { result in
            switch result {
                case .success(let token):
                print(token)
                    defaults.setValue(token, forKey: "jsonwebtoken")
                    DispatchQueue.main.async {
                        self.isAuthenticated = true
                        
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
  
    
}
