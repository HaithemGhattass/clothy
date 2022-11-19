//
//  ClothesCard.swift
//  clothy
//
//  Created by haithem ghattas on 18/11/2022.
//

import SwiftUI

struct ClothesCard: View {
    var clothes : Clothes
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: clothes.image)){ image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .overlay(alignment: .top){ //yomkon nbadel .buttom
                        Text(clothes.name)
                            .font(.headline)
                            .foregroundColor(.white)
                            .shadow(color: .black, radius: 3, x: 0, y: 0)
                            .frame(maxWidth: 136)
                            .padding()
                    }
            }
            placeholder : {
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40, alignment: .center)
                    .foregroundColor(.white.opacity(0.7))
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .overlay(alignment: .top){ //yomkon nbadel .buttom
                        Text(clothes.name)
                            .font(.headline)
                            .foregroundColor(.white)
                            .shadow(color: .black, radius: 3, x: 0, y: 0)
                            .frame(maxWidth: 136)
                            .padding()
                    }
        }
        }
        .frame(width: 160, height: 217, alignment: .top)
        .background(LinearGradient(gradient: Gradient(colors: [Color(.gray).opacity(0.3),Color(.gray)]), startPoint: .top, endPoint: .bottom))
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .shadow(color: Color.black.opacity(0.3), radius: 15, x: 0, y: 10)
        
        //Text(clothes.name)
    }
}

struct ClothesCard_Previews: PreviewProvider {
    static var previews: some View {
        ClothesCard(clothes: Clothes.all[0])
    }
}
