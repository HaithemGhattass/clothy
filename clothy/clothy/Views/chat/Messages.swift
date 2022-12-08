//
//  Messages.swift
//  clothy
//
//  Created by haithem ghattas on 6/12/2022.
//

import SwiftUI

struct Messages: View {
    @StateObject private var vm = UsersViewModel()
    @StateObject var messagesManager = MessagesManager()
    @State var openclothes : Bool  = false
   // @StateObject var settings = MessagesManager()
    var sender : String
    var reciver : String
    var idroom : String

    var body: some View {
        VStack {
            VStack {
                
                    HStack(spacing: 20) {
                        
                        AsyncImage(url: URL(string: vm.HOST_URL + "upload/" + vm.imageF)) { image in
                            image.resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 50, height: 50)
                                .cornerRadius(50)
                        } placeholder: {
                            ProgressView()
                        }
                        
                        VStack(alignment: .leading) {
                            Text(vm.firstname + " " + vm.lastname)
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
                                withAnimation{
                                    openclothes.toggle()

                                }
                            }
                    }
                    .padding()
                

                ScrollViewReader { proxy in
                    ScrollView {
                        ForEach(messagesManager.chats, id: \.id) { chat in
                            MessageBubble(message: chat, id: reciver, idS: sender, idR: idroom)
                            
                        }
                    }
                    
                    .padding(.top, 10)
                    .background(.white)
                    .cornerRadius(30, corners: [.topLeft, .topRight]) // Custom cornerRadius modifier added in Extensions file
                    .onChange(of: messagesManager.lastMessageId) { id in
                        // When the lastMessageId changes, scroll to the bottom of the conversation
                        withAnimation {
                            proxy.scrollTo(id, anchor: .bottom)
                        }
                    }
                }
            }
            .background(
                Image("Blob 1")
                    .offset(x: 250 , y: -190)
            )
            .onAppear{
                vm.getUserTrade(id: reciver)
                print(idroom)
                print("------")
                messagesManager.getMessages(id: idroom)
              //  messagesManager.id = idroom
            }
            featured
            MessageField(id: idroom)
                .environmentObject(messagesManager)
        }
    }
    var featured : some View {
        TabView {
            ForEach(closets) { closet in
                GeometryReader { proxy in
                    let minX = proxy.frame(in: .global).minX
                    matcheditems
                        .padding(.vertical, 40)
                        .rotation3DEffect(.degrees(minX / -10), axis: (x: 0, y: 1, z: 0))
                        .shadow(color: Color("Shadow").opacity(0.3), radius: 10, x: 0, y: 10)
                        .offset(x: abs(minX / 40))
                        .blur(radius: minX)
//                        .overlay(
//                            Image(closet.image)
//                                .resizable()
//                                .aspectRatio(contentMode: .fit)
//                                .frame(height: 230)
//                                .offset(x: 32 , y: -80)
//                                .offset(x: minX / 2)
//                        )
                        .padding(20)
                    //                        .onTapGesture {
                    //                            showcloset = true
                    //                            selectedcloset = closet
                    //                        }
                    
                    // Text("\(proxy.frame(in: .global).minX)")
                }
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .frame(height: openclothes ? 220 : 0)
      
        //        .sheet(isPresented: $showcloset) {
        //            CategoryViewDetails(categroie: selectedcloset.title)
        //                //Text(selectedcloset.title)
        //        }
    }
    var matcheditems: some View {
        VStack(alignment: .leading, spacing : 8.0) {
            Spacer()
           
            Text("closet.title")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundStyle(.linearGradient(colors: [.primary,.primary.opacity(0.5)], startPoint: .topLeading, endPoint: .bottomTrailing))
            Text("closet.subtitle".uppercased())
                .font(.footnote)
                .fontWeight(.semibold)
                .foregroundStyle(.secondary)
            Text("closet.text")
                .font(.footnote)
                .multilineTextAlignment(.leading)
                .lineLimit(2)
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(.secondary)
              
        }
        .padding(/*@START_MENU_TOKEN@*/.all, 20.0/*@END_MENU_TOKEN@*/)
        .padding(.vertical,20)
        .frame(height: 150)
        .background(.ultraThinMaterial)
        .mask(RoundedRectangle(cornerRadius: 30,style: .continuous))
       // .cornerRadius(30)
    //.mask(RoundedRectangle(cornerRadius: 30,style: .continuous))
        .strokeStyle()
        .padding(.horizontal, 20)
      
    }
}

struct Messages_Previews: PreviewProvider {
    static var previews: some View {
        Messages(sender: "a", reciver: "a", idroom: "aa")
    }
}
