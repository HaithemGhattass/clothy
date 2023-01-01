//
//  RoomDetailsView.swift
//  clothy
//
//  Created by haithem ghattas on 11/12/2022.
//

import SwiftUI

struct RoomDetailsView: View {
    

  
    @ObservedObject var wsManager = WebSocketManager()

    var idroom : String
    var iduser : String
    var socket2 : URLSessionWebSocketTask
        @State var text = ""
    init(wsManager: WebSocketManager = WebSocketManager(), idroom: String, iduser: String, text: String = "", socket2 : URLSessionWebSocketTask) {
        self.wsManager = wsManager
        self.idroom = idroom
        self.iduser = iduser
        self.text = text
        self.socket2 = socket2
  // var  socket2: URLSessionWebSocketTask =
  //              URLSession(configuration: .default).webSocketTask(with: URL(string: "ws://192.168.0.88:9090/room/"+idroom)!)
    //    wsManager.getmessages(idroom: idroom)
        wsManager.setup(idroom: idroom,socket2: socket2 )
            
        
    }
   
    var body: some View {
                    VStack{
                        
                        
                        ForEach(self.wsManager.msg,id: \.id) { message in

                            Text(message.message)
                        }
            
                           
                        
                        
                        
                        HStack{
                            TextField("",text: $text)
                            Button{
                                wsManager.sendMessage(message: text,iduser: iduser, idroom: idroom, socket2:  socket2)
                                
                            }label: {
                                Text("send")
                            }
                        }
                    }
    }
}

struct RoomDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        RoomDetailsView(idroom: "aa", iduser: "aa", socket2: URLSession(configuration: .default).webSocketTask(with: URL(string: HostUtils().HOST_WS+"/room/aa")!)
)
    }
}
