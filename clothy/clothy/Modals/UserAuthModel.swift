//
//  UserAuthModel.swift
//  ClothyApp
//
//  Created by Mohamed Amine Mtar on 27/12/2022.
//

import Foundation
import SwiftUI
import GoogleSignIn
import Alamofire
import SwiftyJSON
class UserAuthModel: ObservableObject {
    
    @Published var givenName: String = ""
    @Published var profilePicUrl: String = ""
    @Published var isLoggedIn: Bool = false
    @Published var errorMessage: String = ""
    
    init(){
        check()
    }
    
    func checkStatus(){
        if(GIDSignIn.sharedInstance.currentUser != nil){
            let user = GIDSignIn.sharedInstance.currentUser
            guard let user = user else { return }
            let givenName = user.profile?.givenName
            let profilePicUrl = user.profile!.imageURL(withDimension: 100)!.absoluteString
            self.givenName = givenName ?? ""
            self.profilePicUrl = profilePicUrl
            self.isLoggedIn = true
        }else{
            self.isLoggedIn = false
            self.givenName = "Not Logged In"
            self.profilePicUrl =  ""
        }
    }
    
    func check(){
        GIDSignIn.sharedInstance.restorePreviousSignIn { user, error in
            if let error = error {
                self.errorMessage = "error: \(error.localizedDescription)"
            }
            
            self.checkStatus()
        }
    }
    
    func signIn( completed: @escaping (Bool) -> Void){
        
       guard let presentingViewController = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first?.rootViewController else {return}

        
        GIDSignIn.sharedInstance.signIn(
            withPresenting: presentingViewController){ signInResult, error in
            guard error == nil else { return }
               guard let signInResult = signInResult else { return }

               let user = signInResult.user

               let emailAddress = user.profile?.email

               let fullName = user.profile?.name
               let givenName = user.profile?.givenName
               let familyName = user.profile?.familyName

               let profilePicUrl = user.profile?.imageURL(withDimension: 320)
                print(profilePicUrl ?? "")
                print(user.profile ?? "")
                AF.request(HostUtils().HOST_URL+"api/loginWS",
                           method: .post,
                           parameters: [
                            "email": emailAddress ?? "",
                            
                            "firstname": givenName ?? "",
                            "lastname":familyName ?? "",
                            
                            "pseudo": fullName ?? "",
                          
                            
                            
                            
                           ] ,encoding: JSONEncoding.default)
                .validate(statusCode: 200..<300)
                .validate(contentType: ["application/json"])
                .responseData { response in
                    switch response.result {
                    case .success:
                        
                        let jsonData = JSON(response.data!)
                        print(jsonData)
                        let utilisateur = UsersViewModel().makeItem(jsonItem: jsonData["u"])
                        print("-------"+utilisateur.id)
                        UserDefaults.standard.setValue(utilisateur.id, forKey: "session")
                        
                        completed(true)
                    case .failure:
                        completed(false)
                    }
                }
            
        }
    }
    
    func signOut(){
        GIDSignIn.sharedInstance.signOut()
        self.checkStatus()
    }
}
