//
//  ChatListView.swift
//  clothy
//
//  Created by Mohamed Amine Mtar on 19/12/2022.
//

import SwiftUI

struct ChatListView: View {
    @State var showchats = false
    @State var text = ""
    @State var searchText: String = ""
    @ObservedObject var wsManager = WebSocketManager()
    @State var idroom = ""
    
    @State var iduser = ""
    @State var firstname = ""
    @State var lastaname = ""
    @State var profilepic = ""

    
    
    init() {
        wsManager.setuproom()
        
        
    }
    
    let users = ["Shezad", "Mathew", "Afna", "Jerin", "Catherine"]
    let messages = [
        ["user":"Catherine", "message":"Hi there, How's your work ? did you completed that cross platform app ? ", "time": "10:30 AM"],
        ["user":"Shezad", "message": "Are you available tomorrow at 3:30 pm ? i'd like to discuss about our new project", "time": "12:45 AM"],
        ["user":"Afna", "message": "Hey, is there any update for morning stand up meeting tomorrow ?", "time": "12:15 PM"],
        ["user":"Mathew", "message": "Wow, awesome! Thank you so much for your effort", "time": "4:30 AM"],
        ["user":"Jerin", "message": "Yeah, Let's meet tomrrow evening 5:30pm at coffe shop", "time": "8:17 AM"]]
    
    
    var body: some View {
        if !showchats {
            ZStack{
                Color("color_bg").edgesIgnoringSafeArea(.all)
                VStack{
                    
                    HStack{
                        Text("Chats")
                            .fontWeight(.semibold)
                            .font(.largeTitle)
                        Spacer()
                        Image(systemName: "square.and.pencil")
                            .foregroundColor(Color("color_primary"))
                            .font(.title2)
                    }
                    
                    ScrollView(showsIndicators: false){
                        VStack(alignment: .leading, spacing: 5){
                            
                             Search(searchText: $searchText)
                            
                            //OnlineUsersView(users: users)
                            ScrollView(.horizontal, showsIndicators: false){
                                VStack{
                                    HStack(spacing:25){
                                        ForEach(self.wsManager.users,id: \.user.id) { user in
                                            VStack{
                                                AsyncImage(url: URL(string: HostUtils().HOST_URL + "uploads/" +  user.user.imageF)) { phase in
                                                    if let image = phase.image {
                                                        image
                                                            .resizable()
                                                            .background( Color("color_bg").opacity(0.1))
                                                            .frame(width: 80, height: 80)
                                                            .overlay(Circle().stroke(Color("color_primary"), lineWidth: 5))
                                                            .clipShape(Circle())
                                                        
                                                    } else if phase.error != nil {
                                                        Image(systemName: "person.crop.circle.fill.badge.checkmark")
                                                            .symbolVariant(.circle.fill)
                                                            .font(.system(size: 32))
                                                            .symbolRenderingMode(.palette)
                                                            .foregroundStyle(.blue, .blue.opacity(0.3))
                                                            .padding()
                                                            .background(Circle().fill(.ultraThinMaterial))
                                                        
                                                        
                                                        
                                                        
                                                        // Color.red // Indicates an error.
                                                    } else {
                                                        // Color.blue // Acts as a placeholder.
                                                        Image(systemName: "person.crop.circle.fill.badge.checkmark")
                                                            .symbolVariant(.circle.fill)
                                                            .font(.system(size: 32))
                                                            .symbolRenderingMode(.palette)
                                                            .foregroundStyle(.blue, .blue.opacity(0.3))
                                                            .padding()
                                                            .background(Circle().fill(.ultraThinMaterial))
                                                        
                                                        
                                                    }
                                                }.onTapGesture {
                                                    
                                                    idroom = user.match.id
                                                    iduser = user.user.id
                                                    firstname = user.user.firstname
                                                    lastaname = user.user.lastname
                                                    profilepic = user.user.imageF
                                                    print(firstname+"aaaaaaaaa")
                                               
                                                 
                                                    showchats.toggle()


                                                }
                                                Text("\(user.user.firstname)")
                                                    .fontWeight(.semibold)
                                                    .padding(.top, 3)
                                            }
                                        }
                                    }
                                }
                                .padding(.vertical, 20)
                            }
                            
                            Divider()
                                .padding(.bottom, 20)
                            
                            VStack(spacing: 25){
                                ForEach(self.wsManager.users,id: \.user.id) { room in
                                    HStack {
                                        AsyncImage(url: URL(string: HostUtils().HOST_URL + "uploads/" +  room.user.imageF)) { phase in
                                            if let image = phase.image {
                                                image
                                                    .resizable()
                                                    .background( Color("color_bg").opacity(0.1))
                                                    .frame(width: 80, height: 80)
                                                    .overlay(Circle().stroke(Color("color_primary"), lineWidth: 5))
                                                    .clipShape(Circle())
                                                
                                            } else if phase.error != nil {
                                                Image(systemName: "person.crop.circle.fill.badge.checkmark")
                                                    .symbolVariant(.circle.fill)
                                                    .font(.system(size: 32))
                                                    .symbolRenderingMode(.palette)
                                                    .foregroundStyle(.blue, .blue.opacity(0.3))
                                                    .padding()
                                                    .background(Circle().fill(.ultraThinMaterial))
                                                
                                                
                                                
                                                
                                                // Color.red // Indicates an error.
                                            } else {
                                                // Color.blue // Acts as a placeholder.
                                                Image(systemName: "person.crop.circle.fill.badge.checkmark")
                                                    .symbolVariant(.circle.fill)
                                                    .font(.system(size: 32))
                                                    .symbolRenderingMode(.palette)
                                                    .foregroundStyle(.blue, .blue.opacity(0.3))
                                                    .padding()
                                                    .background(Circle().fill(.ultraThinMaterial))
                                                
                                                
                                            }
                                        }
                                        
                                        VStack(alignment: .leading, spacing: 8){
                                            HStack{
                                                Text(room.user.firstname)
                                                    .fontWeight(.semibold)
                                                    .padding(.top, 3)
                                                Spacer()
                                                Text(((room.user.createdAt).suffix(13)).prefix(5)
                                                )
                                                    .foregroundColor(Color("color_primary"))
                                                    .padding(.top, 3)
                                            }
                                            
                                            
                                            Text(room.user.pseudo)
                                                .foregroundColor(Color("color_bg_inverted").opacity(0.5))
                                                .lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
                                            Divider()
                                                .padding(.top, 8)
                                        }
                                        .padding(.horizontal, 10)
                                    } .onTapGesture {
                                        
                                        idroom = room.match.id
                                        iduser = room.user.id
                                        firstname = room.user.firstname
                                        lastaname = room.user.lastname
                                        profilepic = room.user.imageF
                                        print(firstname+"aaaaaaaaa")
                                      //  wsManager.sendRoom(id: idroom)
                                     
                                        showchats.toggle()


                                    }
                                }
                                
                            }
                        }
                    }
                    .padding(.top)
                    .padding(.horizontal)
                }
            }
        }
        if showchats {
            let socket2 : URLSessionWebSocketTask = URLSession(configuration: .default).webSocketTask(with: URL(string: HostUtils().HOST_WS+"/room/"+idroom)!)
            RoomDetailsView( idroom: idroom, iduser:iduser,firstname:firstname,lastname:lastaname,profilepic: profilepic, socket2: socket2)
//            Text("sending")
//
//            VStack{
//                List(self.wsManager.messages, id: \.self) { message in
//                        Text(message)
//                         }
//                HStack{
//                    TextField("",text: $text)
//                    Button{
//                        wsManager.sendMessage(message: text,iduser: iduser, idroom: idroom)
//                    }label: {
//                        Text("send")
//                    }
//                }
//            }
         
              
           
        }

    }
    
}

struct ChatListView_Previews: PreviewProvider {
    static var previews: some View {
        ChatListView().preferredColorScheme(.dark)
    }
}
