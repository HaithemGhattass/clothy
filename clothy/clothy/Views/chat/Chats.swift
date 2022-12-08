//
//  ChatRooms.swift
//  clothy
//
//  Created by haithem ghattas on 6/12/2022.
//

import SwiftUI

struct Chats: View {
    var body: some View {
        NavigationView {
            ScrollView{
                HStack {
                   Image("aaaa")
                       // .font(.system(size: 32))
                        .resizable()
                        .frame(width: 36, height: 36)
                        .mask(Circle())
                        .padding(12)
                        .background(Color(UIColor.systemBackground).opacity(0.3))
                        .mask(Circle())
                    VStack(alignment: .leading){
                        Text("username")
                            .fontWeight(.semibold)
                        Text("message sent to user")
                            .font(.caption.weight(.medium))
                            .foregroundStyle(.secondary)
                    }
                    Spacer()
                    Text("22D")
                        .font(.system(size: 14 , weight: .light))
                        .foregroundStyle(.secondary)
                }
                Divider()
                    .padding(.vertical,8)
            }.padding(.horizontal)
            
        }
        
    }
}

struct Chats_Previews: PreviewProvider {
    static var previews: some View {
        Chats()
    }
}
