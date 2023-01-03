//
//  RoomDetailsView.swift
//  clothy
//
//  Created by haithem ghattas on 11/12/2022.
//

import SwiftUI

struct RoomDetailsView: View {
    

    @ObservedObject private var Vm = UsersViewModel()
    @ObservedObject var wsManager = WebSocketManager()
    @ObservedObject var outfitvm = OutfitViewModel()
    @State var selected : String = ""
    @State var openclothes : Bool = false
    @State var openclothesR : Bool = false

    @State var selectedone : String = ""
    @State var selectedtwo : String = ""
    

    
    var idroom : String
    var iduser : String
    var firstname : String
    var lastname : String
    var profilepic : String
    
    var socket2 : URLSessionWebSocketTask
        @State var text = ""
   
    init(wsManager: WebSocketManager = WebSocketManager(), idroom: String, iduser: String, text: String = "",firstname: String,lastname: String,profilepic: String, socket2 : URLSessionWebSocketTask) {
        self.firstname = firstname
        self.lastname = lastname
        self.profilepic = profilepic
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
         HStack(spacing: 20) {
             AsyncImage(url: URL(string: HostUtils().HOST_URL + "uploads/" + profilepic)) { image in
                 image.resizable()
                     .aspectRatio(contentMode: .fill)
                     .frame(width: 50, height: 50)
                     .cornerRadius(50)
             } placeholder: {
                 ProgressView()
             }
             
             VStack(alignment: .leading) {
                 Text(firstname + " " + lastname)
                     .font(.title).bold()
                 
                 Text("Online")
                     .font(.caption)
                     .foregroundColor(.gray)
             }
             .frame(maxWidth: .infinity, alignment: .leading)
             
             Image(systemName: "tshirt.fill")
                 .foregroundColor(.gray)
                 .padding(10)
                 .background(.white)
                 .cornerRadius(50)
                 .onTapGesture {
                     openclothesR = false
                     openclothes.toggle()
                     outfitvm.matchoutfit(matchid: idroom)
                         
                    
                 }
             Image(systemName: "tshirt")
                 .foregroundColor(.gray)
                 .padding(10)
                 .background(.white)
                 .cornerRadius(50)
                 .onTapGesture {
                     openclothes = false
                     openclothesR.toggle()
                     openclothes = false
                     outfitvm.matchoutfitR(matchid: idroom)

                     print("tapped")
                    
                 }

         }
         .padding()
     
             .background(Color("background4"))
         ScrollView{
             ForEach(self.wsManager.msg,id: \.id) { message in
                 
                 MessageBubble(message: Msg(to: message.to, id:message.id, matchID:message.matchID, v: message.v, from: message.from, message: message.message, updatedAt: message.updatedAt, createdAt: message.createdAt))
                 
             }
             .flippedUpsideDown()
             
             
         }
         .flippedUpsideDown()
                        
                        
//                        HStack{
//                            TextField("",text: $text)
//                            Button{
//                                wsManager.sendMessage(message: text,iduser: iduser, idroom: idroom, socket2:  socket2)
//
//                            }label: {
//                                Text("send")
//                            }
//                        }
         TabView {
             ForEach(self.outfitvm.clothes,id: \.id) { closet in
           
                 MatchedItemsView(type: closet.typee, taille: closet.taille, couleur: closet.couleur,image:closet.photo,id:closet.id)
                     .border(closet.id == selectedone || closet.id == selectedtwo  ? .green : .white)
                     //.border(selected ? .green : .white)
                     .onTapGesture {
                         selected = closet.id;
                        
                         if(openclothes == true){
                                 if selectedone == closet.id{
                                     selectedone = ""
                                 }else {
                                     selectedone = closet.id
                                 }
                                 print(selectedone + "first")
                             } else {
                                 if selectedtwo == closet.id{
                                     selectedtwo = ""
                                 }else {
                                     selectedtwo = closet.id
                                 }
                                 print(selectedtwo + "second")
                             }
                            
                           //  print(id + " 111111")
                             
                               

                            
                        }
                       
                         
                     //                        .onTapGesture {
                     //                            showcloset = true
                     //                            selectedcloset = closet
                     //                        }
                     
                     // Text("\(proxy.frame(in: .global).minX)")
                 
              
             }
           
         }
     
        
         
             .frame(height: openclothes || openclothesR ? 200 : 0)
             
         HStack {
             
             // Custom text field created below
             Custom(placeholder: Text("Enter your message here"), text: $text)
                 .frame(height: 52)
                 .disableAutocorrection(true)

             Button {
                 wsManager.sendMessage(message: text,iduser: iduser, idroom: idroom, socket2:  socket2)
                 text = ""
                 
             } label: {
                 Image(systemName: "paperplane.fill")
                     .foregroundColor(.white)
                     .padding(10)
                     .background(Color(hex:"e9e9e9"))
                    .cornerRadius(50)
             }
             Button {
                 if(selectedone != "" && selectedtwo != ""){
                     outfitvm.trade(idroom: idroom,totrade:selectedone,totradeR:selectedtwo)
                 }
                 
             } label: {
                 Image(systemName: "arrow.left.arrow.right")
                     .foregroundColor(.white)
                     .padding(10)
                     .background(Color(hex:"e9e9e9"))
                    .cornerRadius(50)
             }
             
         }
         .padding(.horizontal)
         .padding(.vertical, 10)
         .background(Color("Gray"))
         .cornerRadius(50)
         .padding()
         
                    }
     .onAppear{
         Vm.fetchuser()
     }
                    .background(.ultraThinMaterial)
    }
}

struct RoomDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        RoomDetailsView(idroom: "aa", iduser: "aa",firstname: "ha",lastname: "a",profilepic: "az", socket2: URLSession(configuration: .default).webSocketTask(with: URL(string: HostUtils().HOST_WS+"/room/aa")!)
)
    }
}
struct Custom: View {
    var placeholder: Text
    @Binding var text: String
    var editingChanged: (Bool)->() = { _ in }
    var commit: ()->() = { }

    var body: some View {
        ZStack(alignment: .leading) {
            // If text is empty, show the placeholder on top of the TextField
            if text.isEmpty {
                placeholder
                .opacity(0.5)
            }
            TextField("", text: $text, onEditingChanged: editingChanged, onCommit: commit)
        }
    }
}

struct FlippedUpsideDown: ViewModifier {
   func body(content: Content) -> some View {
    content
           .rotationEffect(Angle.degrees(180))
      .scaleEffect(x: -1, y: 1, anchor: .center)
   }
}
extension View{
   func flippedUpsideDown() -> some View{
     self.modifier(FlippedUpsideDown())
   }
}
