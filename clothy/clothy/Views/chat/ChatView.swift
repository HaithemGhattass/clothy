//
//  ChatView.swift
//  clothy
//
//  Created by haithem ghattas on 4/12/2022.
//

import SwiftUI

struct ChatView: View {
    @StateObject var messagesManager = MessagesManager()

    @StateObject private var vm = UsersViewModel()
    @State var appear = [false, false, false]
    @State var showchats = false
    @State var sender = ""
    @State var reciver = ""
    @State var idroom = ""

    @State var viewState: CGSize = .zero
    var isAnimated = true
    @EnvironmentObject var model: Model


 //   @StateObject var messagesManager = MessagesManager()
    
    var body: some View {
        if !showchats {
            VStack {
                
                
                NavigationView {
                    
                    ScrollView {
                        ForEach(messagesManager.messages, id: \.id) { message in
                            if(message.reciver == vm.id || message.sender == vm.id ){
                                if(message.reciver == vm.id){
                                    //  MessageBubble(id: message.sender , message: message)
                                    RoomRow(user: message.sender)
                                        .onTapGesture {
                                            showchats.toggle()
                                            sender = message.reciver
                                            reciver = message.sender
                                            idroom = message.id

                                        }
                                        
                                    
                                }else {
                                    //  MessageBubble(id: message.reciver , message: message)
                                    RoomRow(user: message.reciver)
                                        .onTapGesture {
                                            showchats.toggle()
                                            sender = message.sender
                                            reciver = message.reciver
                                            idroom = message.id
                                        }
                                    
                                }
                                
                            }
                        }
                        
                    }
                    
                    .onAppear{
                        vm.fetchuser()
                    }
                    
                    .background(.ultraThinMaterial)
                   
                    
                    
                    
                  
                    .backgroundStyle(cornerRadius: 30)
                    //  .padding(.top, 10)
                    //  .background(.white)
                    //  .cornerRadius(30, corners: [.topLeft, .topRight]) // Custom cornerRadius
                    
                    
                    
                    //modifier added in Extensions file
                    /* .onChange(of: messagesManager.lastMessageId) { id in
                     // When the lastMessageId changes, scroll to the bottom of the conversation
                     withAnimation {
                     proxy.scrollTo(id, anchor: .bottom)
                     }
                     }
                     */
                    
                    
                    //.background( Image("Background 5"))
                    
                    //  MessageField()
                    //    .environmentObject(messagesManager)
                }
              
            }
            .coordinateSpace(name: "scroll")
            .background(
                Image("Blob 1")
                    .offset(x: 250 , y: -100)
            )
            .mask(RoundedRectangle(cornerRadius:  30))
           
          
            
           
        }
        if showchats {
            Messages(sender: sender,reciver: reciver, idroom: idroom)
        }
       
       
        
      
     
        
    }

}


struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
}
