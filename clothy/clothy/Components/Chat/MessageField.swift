//
//  MessageField.swift
//  clothy
//
//  Created by haithem ghattas on 4/12/2022.
//

import SwiftUI

import SwiftUI

struct MessageField: View {
    @State var id: String
    @EnvironmentObject var messagesManager: MessagesManager
    @StateObject private var vm = UsersViewModel()

    @State private var message = ""
 
    var body: some View {
        HStack {
            // Custom text field created below
            CustomTextFieldChat(placeholder: Text("Enter your message here"), text: $message)
                .frame(height: 52)
                .disableAutocorrection(true)

            Button {
                messagesManager.sendMessage(text: message, id: id ,from : vm.id)
                message = ""
            } label: {
                Image(systemName: "paperplane.fill")
                    .foregroundColor(Color(hex:"f498ad"))
                    .padding(10)
                    .background(Color(hex:"e9e9e9"))
                    .cornerRadius(50)
            }
        }
        .onAppear{
            vm.fetchuser()
        }
        .padding(.horizontal)
        .padding(.vertical, 10)
        .background(Color("Gray"))
        .cornerRadius(50)
        .padding()
    }
}

struct MessageField_Previews: PreviewProvider {
    static var previews: some View {
        MessageField(id: "a")
            .environmentObject(MessagesManager())
    }
}

struct CustomTextFieldChat: View {
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

