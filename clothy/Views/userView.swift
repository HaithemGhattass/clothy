//
//  userView.swift
//  clothy
//
//  Created by Mohamed Amine Mtar on 11/11/2022.
//

import SwiftUI

struct UserView: View {
    
    let user: User
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("**Name**: \(user.firstname)")
            Text("**Email**: \(user.email)")
            Divider()
            Text("**Company**: \(user.pseudo)")

        }
        .frame(maxWidth: .infinity,
               alignment: .leading)
        .padding()
        .background(Color.gray.opacity(0.1), in: RoundedRectangle(cornerRadius: 10, style: .continuous))
        .padding(.horizontal, 4)
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView(user: .init(firstname: "String", lastname: "String", birthdate: "String", pseudo: "String", imageF: "String", email: "String", phone: 9999999, password: "String",isVerified: false, preference: "String", gender: "String", id: "String", createdAt: "String", updatedAt: "String", v: 0))
    }
}
