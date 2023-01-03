//
//  MessageBubble.swift
//  ClothyApp
//
//  Created by Mohamed Amine Mtar on 28/12/2022.
//



import SwiftUI

struct MessageBubble: View {
    var message: Msg
    
    @State private var showTime = false
    @StateObject private var vm = UsersViewModel()
        //@StateObject private var mm = MessagesManager(inputid: "")
    

    var body: some View {
        VStack(alignment: message.to == vm.id ? .leading : .trailing) {
            HStack {
                Text(message.message)
                    .padding()
                    .background(message.to == vm.id ? Color(hex:"e9e9e9") : Color(hex:"f498ad"))
                    .cornerRadius(30)
            }
            .frame(maxWidth: 300, alignment: message.to == vm.id ? .leading : .trailing)
            .onTapGesture {
                showTime.toggle()
            }
            
           
        }
        .onAppear{
            vm.fetchuser()
        }
        .frame(maxWidth: .infinity, alignment: message.to == vm.id ? .leading : .trailing)
        .padding(message.to == vm.id ? .leading : .trailing)
        .padding(.horizontal, 10)
    }
}

struct MessageBubble_Previews: PreviewProvider {
    static var previews: some View {
        MessageBubble(message: Msg(to: "", id: "", matchID: "", v: 0, from: "", message: "hahahhaha", updatedAt: "", createdAt: ""))
    }
}
