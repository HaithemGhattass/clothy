//
//  MessagesManager.swift
//  clothy
//
//  Created by haithem ghattas on 5/12/2022.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import SwiftyJSON

class MessagesManager: ObservableObject {
    @Published private(set) var messages: [Room] = []
    @Published private(set) var chats: [Message] = []
    @Published private(set) var chartrooms: [ChatRooms] = []
    
    @Published private(set) var lastMessageId: String = ""
    // Create an instance of our Firestore database
    let db = Firestore.firestore()
    // On initialize of the MessagesManager class, get the messages from Firestore
    init() {
        
       
        getMessagesRooms()
       // getMessages(id: id)

    }
    
    // Read message from Firestore in real-time with the addSnapShotListener
    func getMessagesRooms() {
        db.collection("Chatrooms").addSnapshotListener { querySnapshot, error in
            
            // If we don't have documents, exit the function
            guard let documents = querySnapshot?.documents else {
                print("Error fetching documents: \(String(describing: error))")
                return
            }
            
            // Mapping through the documents
            self.messages = documents.compactMap { document -> Room? in
                do {
                    // Converting each document into the Message model
                    // Note that data(as:) is a function available only in FirebaseFirestoreSwift package - remember to import it at the top
                    return try document.data(as: Room.self)
                } catch {
                    // If we run into an error, print the error in the console
                    print("Error decoding document into Message: \(error)")
                    
                    // Return nil if we run into an error - but the compactMap will not include it in the final array
                    return nil
                }
            }
        }
    }
    func createroom(sender: String , reciver : String) {
        let db = Firestore.firestore()
        let roomname =  reciver  + sender
        let docRef = db.collection("Chatrooms").document(roomname)
            
        docRef.setData(["id": roomname , "sender": sender , "reciver": reciver]) { error in
            if let error = error {
                print("Error writing document: \(error)")
            } else {
                print("Document successfully written!")
            }
        }
        docRef.collection("messages").document().setData([  // 👈 Create a document in the subcollection
            :])
    }
    
    func getMessages(id: String) {
        db.collection("Chatrooms").document(id).collection("messages").addSnapshotListener { querySnapshot, error in
            
            // If we don't have documents, exit the function
            guard let documents = querySnapshot?.documents else {
                print("Error fetching documents: \(String(describing: error))")
                return
            }
            
            // Mapping through the documents
            self.chats = documents.compactMap { document -> Message? in
                do {
                    // Converting each document into the Message model
                    // Note that data(as:) is a function available only in FirebaseFirestoreSwift package - remember to import it at the top
                    print(document.data() )
                    print("ty ahaya lenna chouf traaaaaaah")
                    return try document.data(as: Message.self)
                } catch {
                    // If we run into an error, print the error in the console
                    print("Error decoding document into Message: \(error)")

                    // Return nil if we run into an error - but the compactMap will not include it in the final array
                    return nil
                }
            }
            
            // Sorting the messages by sent date
            self.chats.sort { $0.timestamp < $1.timestamp }
            
            // Getting the ID of the last message so we automatically scroll to it in ContentView
            if let id = self.chats.last?.id {
                self.lastMessageId = id
            }
        }
    }
    func sendMessage(text: String , id: String, from: String) {
        do {
            // Create a new Message instance, with a unique ID, the text we passed, a received value set to false (since the user will always be the sender), and a timestamp
            let newMessage = Message(id: "\(UUID())", text: text, from: from, timestamp: Date())
            
            // Create a new document in Firestore with the newMessage variable above, and use setData(from:) to convert the Message into Firestore data
            // Note that setData(from:) is a function available only in FirebaseFirestoreSwift package - remember to import it at the top
            try   db.collection("Chatrooms").document(id).collection("messages").document().setData(from: newMessage)
            
        } catch {
            // If we run into an error, print the error in the console
            print("Error adding message to Firestore: \(error)")
        }
    }



}
