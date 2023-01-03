//
//  WebSocketManager.swift
//  clothy
//
//  Created by haithem ghattas on 9/12/2022.
//

import SwiftUI
import SwiftyJSON
class WebSocketManager: ObservableObject {
    @Published var messages: [String] = []
    @Published var users = [Rooms] ()
    @Published var msg = [Msg] ()
    @Published var comingmessage : [String] = []
   // @Published private(set) var lastMessageId: String = ""

    var email: String = ""
    public let socket: URLSessionWebSocketTask =
    URLSession(configuration: .default).webSocketTask(with: URL(string: HostUtils().HOST_WS)!)
    
    
    func close() {
        socket.cancel(with: .goingAway, reason: nil)

    }
    

    
    func getmessages(idroom: String, socket2: URLSessionWebSocketTask) {
        print("dkhlt v2")

        socket2.receive { result in
            switch result {
            case .failure(let error):
                print("Error Detected: \(error)")
            case .success(let message):
                

                switch message {
                case .string(let text):
                   // print(text)
                    let data = text.data(using: .utf8)!
                    let jsonData = try! JSONSerialization.jsonObject(with: data , options: .fragmentsAllowed)
                        let mess = self.makeMsg(jsonItem: JSON(jsonData))
                        DispatchQueue.main.async {
                            //  self.messages.append(mess)
                            self.msg.append(mess)
                        //    self.msg.sort{ $0.createdAt < $1.createdAt }

//                            if let id = self.msg.last?.id {
//                                self.lastMessageId = id
//                            }
                        }
                   
                    
                
//                        if JSON(jsonData)["room"].exists() {
//
//                            let utilisateur = self.makeItem(jsonItem: JSON(jsonData))
//
//
//
//                            print(JSON(jsonData)["room"]["IdOutfitR"].description)
//                            print("---- oghzor lfouk")
//                            //      self.messages.append("rr: \(JSON(jsonData)["room"].description)")
//                            DispatchQueue.main.async {
//
//
//                                self.users.append(utilisateur)
//                            }
//                        }
                    
                       // if JSON(jsonData)["from"].exists(){
                           // let message = self.makeItem(jsonItem: JSON(jsonData))
                //   else{
                      
                    
                    
                    
                  //  }
                          
                        
                 

//                            if let items = JSON(jsonData)["room"].array {
//                                for item in items {
//                                    if let title = item["IdSession"].string {
//                                      //  print(title)
//                                        self.messages.append("You: \(title)")
//
//
//                                    }
//                                }
//                            }
                    
                    
                default:
                    print("Received data different format data")
                }
                self.getmessages(idroom: idroom, socket2: socket2)
            }
        


    }
        
        
    }
    func setuproom() {
        socket.resume()
        self.getrooms()
    }
    func setup(idroom : String,socket2:URLSessionWebSocketTask) {
       
        
        socket2.resume()
        self.getmessages(idroom: idroom, socket2: socket2)
     // self.receiveMessage()
      //  self.getrooms()
      
    }
    func  creatematch(reciver: String) {
        self.socket.send(.string("reciver")) { (err) in
            if err != nil {
                print("Error on sending: \(err.debugDescription)")
            }else {
                print("rani baathet hazbi")
            }
        }
        self.getrooms()

    }
    func sendRoom(id: String) {
        
        
        
        let messageDictionary : [String: Any] = [ "idroom": id]
        let jsonData = try! JSONSerialization.data(withJSONObject: messageDictionary, options: [])
       // let jsonString = String(data: jsonData, encoding: String.Encoding.ascii)!
       // print (jsonString)
        
        //let jsonResultData = try! jsonEncoder.encode(message)
       // print(jsonResultData.description)
     
        self.socket.send(.data(jsonData)) { (err) in
            if err != nil {
                print("Error on sending: \(err.debugDescription)")
            }
        }
      
      
    }

    func sendMessage(message: String, iduser: String,idroom: String,socket2: URLSessionWebSocketTask) {
       
     //   let jsonEncoder = JSONEncoder()
        let id = UUID().description

        let messageDictionary : [String: Any] = ["to":iduser, "message": message, "idMatch": idroom ]
        let jsonData = try! JSONSerialization.data(withJSONObject: messageDictionary, options: [])
        let newMsg = Msg(to: iduser, id: id, matchID: idroom, v: 0, from: "", message: message, updatedAt: "", createdAt: DateUtils.formatFromDate(date: Date.now))
       // let jsonString = String(data: jsonData, encoding: String.Encoding.ascii)!
       // print (jsonString)
        
        //let jsonResultData = try! jsonEncoder.encode(message)
       // print(jsonResultData.description)
     print("dkhaltv1")
        socket2.send(.data(jsonData)) { (err) in
            if err != nil {
                print("Error on sending: \(err.debugDescription)")
            }else{
                print("dkhaalt")
            }
        }
        self.msg.append(newMsg)
        //    self.getmessages(idroom: idroom, socket2: socket2)
    }
    func receiveMessage() {
            socket.receive { result in
                switch result {
                case .failure(let error):
                    print("Error Detected: \(error)")
                case .success(let message):
                    

                    switch message {
                    case .string(let text):
                       // print(text)
                        
                        
                        let data = text.data(using: .utf8)!
                        let jsonData = try! JSONSerialization.jsonObject(with: data , options: .fragmentsAllowed)
//                        if JSON(jsonData)["room"].exists() {
//
//                            let utilisateur = self.makeItem(jsonItem: JSON(jsonData))
//
//
//
//                            print(JSON(jsonData)["room"]["IdOutfitR"].description)
//                            print("---- oghzor lfouk")
//                            //      self.messages.append("rr: \(JSON(jsonData)["room"].description)")
//                            DispatchQueue.main.async {
//
//
//                                self.users.append(utilisateur)
//                            }
//                        }
                        
                           // if JSON(jsonData)["from"].exists(){
                               // let message = self.makeItem(jsonItem: JSON(jsonData))
                    //   else{
                            print(text)
                            DispatchQueue.main.async {
                                self.messages.append("\(JSON(jsonData))")
                            }
                        
                      //  }
                              
                            
                     

//                            if let items = JSON(jsonData)["room"].array {
//                                for item in items {
//                                    if let title = item["IdSession"].string {
//                                      //  print(title)
//                                        self.messages.append("You: \(title)")
//
//
//                                    }
//                                }
//                            }
                        
                        
                    default:
                        print("Received data different format data")
                    }
                    self.receiveMessage()
                }
            

  
        }
        
    }
    
    func getrooms() {
        socket.receive { result in
            switch result {
            case .failure(let error):
                print("Error Detected: \(error)")
            case .success(let message):
                switch message {
                case .string(let text):
                    let data = text.data(using: .utf8)!
                    let jsonData = try! JSONSerialization.jsonObject(with: data , options: .fragmentsAllowed)
                let rooms = self.makeItem(jsonItem: JSON(jsonData))
                    
                 //   print(rooms.match.idOutfit)
                    let array = rooms.match.idOutfit
                        print(rooms.match.idOutfit)
//                    for item in array {
//                        print(item)
//                        print("aaasdsd")
//                    }
                  

                    DispatchQueue.main.async {
                        self.users.append(rooms)
                    }
                default:
                    print("Received data different format data")
                }
                self.getrooms()
            }
        }
    }
    func lastMessage() {
        socket.receive { result in
            switch result {
            case .failure(let error):
                print("Error Detected: \(error)")
            case .success(let message):
                switch message {
                case .string(let text):
                    DispatchQueue.main.async {
                        self.messages.append("You: \(text)")
                    }
                default:
                    print("Received data different format data")
                }
                self.receiveMessage()
            }
        }
    }
    
    func makeItem(jsonItem: JSON) -> Rooms {
        
        return Rooms(user: User(
                    firstname: jsonItem["user"]["firstname"].stringValue,
                    lastname: jsonItem["user"]["lastname"].stringValue,
                    pseudo: jsonItem["user"]["pseudo"].stringValue,
                    birthdate: jsonItem["user"]["birthdate"].stringValue,
                    imageF: jsonItem["user"]["imageF"].stringValue,
                    email: jsonItem["user"]["email"].stringValue,
                    password: jsonItem["user"]["password"].stringValue,
                    preference: jsonItem["user"]["preference"].stringValue,
                    gender: jsonItem["user"]["gender"].stringValue,
                    id: jsonItem["user"]["_id"].stringValue,
                    createdAt: jsonItem["user"]["createdAt"].stringValue,
                    updatedAt: jsonItem["user"]["updatedAt"].stringValue,
                    isVerified: jsonItem["user"]["isVerified"].boolValue,
                    phone:jsonItem["user"]["phone"].intValue,
                    v:jsonItem["user"]["__v"].intValue), match: Match(id: jsonItem["room"]["_id"].stringValue, idSession: jsonItem["room"]["IdSession"].stringValue, idReciver: jsonItem["room"]["IdReciver"].stringValue, idOutfit: [jsonItem["room"]["IdOutfit"].stringValue], idOutfitR: [jsonItem["room"]["IdOutfit"].stringValue], createdAt: jsonItem["room"]["createdAt"].stringValue, updatedAt: jsonItem["room"]["updatedAt"].stringValue, v: 0))
    }
    func makeMsg(jsonItem: JSON) -> Msg {
        
        return Msg(to: jsonItem["msg"]["to"].stringValue, id: jsonItem["msg"]["_id"].stringValue, matchID: jsonItem["msg"]["matchID"].stringValue, v: jsonItem["msg"]["__v"].intValue, from: jsonItem["msg"]["from"].stringValue, message: jsonItem["msg"]["message"].stringValue, updatedAt: jsonItem["msg"]["updatedAt"].stringValue, createdAt: jsonItem["msg"]["createdAt"].stringValue)
    }
}
