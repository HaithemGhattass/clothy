//
//  PrefButton.swift
//  clothy
//
//  Created by haithem ghattas on 7/11/2022.
//

import SwiftUI

struct PrefButton: View {
    var buttonText = "My Button"
    var buttonColor = Color.white
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 20)
                .frame(width: 150,height: 55)
          
                .padding(16)
                .foregroundColor(Color(hex: "F77D8E"))
              
            .shadow(color: Color(hex: "F77D8E").opacity(0.5), radius: 20, x: 0, y: 10)
            Text("My Button").foregroundColor(.white)      .customFont(.headline)
            LeftCorner()
                .trim(from: 0.41, to: 0.59)
                .fill(buttonColor)
                .frame(width: 140, height: 55)
        }
    }
}
struct LeftCorner: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addRoundedRect(in: rect, cornerSize: CGSize(width: 30, height: 10))
        return path
    }
}

struct PrefButton_Previews: PreviewProvider {
    static var previews: some View {
        PrefButton()
    }
}
