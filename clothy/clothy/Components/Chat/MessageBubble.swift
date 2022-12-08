//
//  MessageBubble.swift
//  clothy
//
//  Created by haithem ghattas on 4/12/2022.
//
import SwiftUI

import SwiftUI

struct MessageBubble: View {
    var message: Message
    var id : String
    var idS : String
    var idR : String
    @State private var showTime = false
    @StateObject private var vm = UsersViewModel()
        //@StateObject private var mm = MessagesManager(inputid: "")
    @StateObject var settings = MessagesManager()

    var body: some View {
        VStack(alignment: message.from != vm.id ? .leading : .trailing) {
            HStack {
                Text(message.text)
                    .padding()
                    .background(message.from != vm.id ? Color(hex:"e9e9e9") : Color(hex:"f498ad"))
                    .cornerRadius(30)
            }
            .frame(maxWidth: 300, alignment: message.from != vm.id ? .leading : .trailing)
            .onTapGesture {
                showTime.toggle()
            }
            
            if showTime {
                Text("\(message.timestamp.formatted(.dateTime.hour().minute()))")
                    .font(.caption2)
                    .foregroundColor(.gray)
                    .padding(message.from != vm.id ? .leading : .trailing, 25)
            }
        }
        .onAppear{
            vm.fetchuser()
            
         
             //   MessagesManager().getMessages(id: idR)

            
           // MessagesManager(inputid: idR).getMessages(id: idR)
           // mm.getMessages(id: idR)
           // MessagesManager().id = idR
        }
        .frame(maxWidth: .infinity, alignment: message.from != vm.id ? .leading : .trailing)
        .padding(message.from != vm.id ? .leading : .trailing)
        .padding(.horizontal, 10)
    }
}

struct MessageBubble_Previews: PreviewProvider {
    static var previews: some View {
        MessageBubble(message: Message(id: "12345", text: "I've been coding applications from scratch in SwiftUI and it's so much fun!", from: "haithem", timestamp: Date()), id:"aa", idS: "aa", idR: "aaa")
    }
}
