//
//  ForgotPWView.swift
//  clothy
//
//  Created by haithem ghattas on 8/11/2022.
//

import SwiftUI

struct ForgotPWView: View {
    @State var email = ""

    var body: some View {
        VStack(spacing: 24) {
            
            Text("Forgot password")
                .customFont(.title2)
            VStack(alignment: .leading) {
                Text("Email")
                    .customFont(.subheadline)
                    .foregroundColor(.secondary)
                TextField("", text: $email)
                    .customTextField()
                
                Button {
                    
                    
                    
                    
                } label: {
                    Label("Reset password", systemImage: "arrow.right")
                        .customFont(.headline)
                        .padding(20)
                        .frame(maxWidth: .infinity)
                        .background(Color(hex: "F77D8E"))
                        .foregroundColor(.white)
                        .cornerRadius(20, corners: [.topRight, .bottomLeft, .bottomRight])
                        .cornerRadius(8, corners: [.topLeft])
                        .shadow(color: Color(hex: "F77D8E").opacity(0.5), radius: 20, x: 0, y: 10)
                }
            }
        }
        .padding(30)
        .background(.regularMaterial)
        .mask(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .shadow(color: Color("Shadow").opacity(0.3), radius: 5, x: 0, y: 3)
        .shadow(color: Color("Shadow").opacity(0.3), radius: 30, x: 0, y: 30)
        .overlay(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .stroke(.linearGradient(colors: [.white.opacity(0.8), .white.opacity(0.1)], startPoint: .topLeading, endPoint: .bottomTrailing))
        )
        .padding()
    }
}

struct ForgotPWView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPWView()
    }
}
