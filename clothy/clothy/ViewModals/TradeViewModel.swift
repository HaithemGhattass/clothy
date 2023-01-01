//
//  TradeViewModel.swift
//  clothy
//
//  Created by haithem ghattas on 4/12/2022.
//

import Foundation
import Alamofire
import SwiftyJSON
import UIKit

final class TradeViewModel : ObservableObject{
    
    var vm = UsersViewModel()
    @Published var hasError = false
    @Published var error: TradeError?
    var mg = WebSocketManager()
    @Published private(set) var isRefreshing = false
    @Published var clothes = [Clothes] ()
    @Published var tickets = [TicketModel] ()
    
    @Published var type: String = ""
    @Published var taille: String = ""
    @Published var couleur: String = ""
    @Published var description: String = ""
    @Published var userID: String = ""
    @Published var photo: String = ""
    @Published var firebase: String = ""

    
  
    init() {
        self.mg.setuproom()
    }
    
    
    func getall(){
        // let userid = UserDefaults.standard.integer(forKey: "userID")
        
        let clothesURL = HostUtils().HOST_URL+"outfit/allOFT"
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
                            self?.error = TradeError.custom(error: error)
                            print(error)
                            print("couldnt enter")
                            
                        } else {
                            
                            let decoder = JSONDecoder()
                            decoder.keyDecodingStrategy = .convertFromSnakeCase // Handle properties that look like
                            print("enter to trade ...")
                            
                            if let data = data,
                               let TicketModel = try? decoder.decode([TicketModel].self, from: data) {
                                self?.tickets  = TicketModel
                                print(self?.tickets ?? "taabitch")
                            } else {
                                self?.hasError = true
                                self?.error = TradeError.failedToDecode
                                
                            }
                        }
                    }
                }.resume()
        }
        
    }
    
    
    func getswiped(completed: @escaping (Bool) -> Void)  {
        
        // let userid = UserDefaults.standard.integer(forKey: "userID")
        let useridd = UserDefaults.standard.string(forKey: "userID")
        print(useridd ?? "noope")
        let clothesURL = HostUtils().HOST_URL+"outfit/getswiped/"
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
                            self?.error = TradeError.custom(error: error)
                            completed(false)
                        }
                        else {
                            completed(true)
                            
                        }
                    }
                    
                    
                    
                    
                    
                }.resume()
        }
        
    }
    
     
    
    
    
    func swipeleft(IdOutfit: String, IdOutfitR: String , reciver: String) {
        print(reciver)
        AF.request(HostUtils().HOST_URL+"match/swipe/"+reciver,
                   method: .put,
                   parameters: [
                    "IdOutfit": IdOutfit,
                    "IdOutfitR": IdOutfitR,
                    
                   ] ,encoding: JSONEncoding.default)
        .validate(statusCode: 200..<300)
        .validate(contentType: ["application/json"])
        .responseData { response in
            switch response.result {
            case .success:
                print("Validation Successful")
                //  completed(true)
                
                
                let jsonData = JSON(response.data!)
                print(jsonData)
                print("----------")
              //  print(jsonData["userID"])
                print("----------")
                //User().pseudo = jsonData["pseudo"].stringValue
                
                
                if jsonData["firebase"].exists() {
                    let firebase = JSON(["firebase"])
                    print(firebase)
                    
                  
                    
                    self.mg.socket.send(.string(reciver)) { (err) in
                        print("khdemt loula")
                        if err != nil {
                            print("Error on sending: \(err.debugDescription)")
                        }else {
                            print("rani baathet")
                        }
                    }
                    
                //    MessagesManager().createroom( sender: user,reciver: reciver)
                    
                    
                }else {
                    print("still")
                }
              
               
               
                
                
            case let .failure(error):
                print(error)
                //    completed(false)
            }
        }
    }

}


extension TradeViewModel {
    enum TradeError: LocalizedError {
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
func stringify(json: Any, prettyPrinted: Bool = false) -> String {
    var options: JSONSerialization.WritingOptions = []
    if prettyPrinted {
      options = JSONSerialization.WritingOptions.prettyPrinted
    }

    do {
      let data = try JSONSerialization.data(withJSONObject: json, options: options)
      if let string = String(data: data, encoding: String.Encoding.utf8) {
        return string
      }
    } catch {
      print(error)
    }

    return ""
}
