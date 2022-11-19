//
//  ClothesDetailView.swift
//  clothy
//
//  Created by haithem ghattas on 18/11/2022.
//

import SwiftUI

struct ClothesDetailView: View {
    var clothes : Clothes
    var body: some View {
        ScrollView {
            AsyncImage(url: URL(string: clothes.image)){ image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    
            }
            placeholder : {
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
//                    .frame(width: 100, height: .infinity, alignment: .center)
                    .foregroundColor(.white.opacity(0.7))
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                
        }
     //       .frame(height: .infinity)
            .background(LinearGradient(gradient: Gradient(colors: [Color(.gray).opacity(0.3),Color(.gray)]), startPoint: .top, endPoint: .bottom))

            VStack(spacing: 30){
                Text(clothes.name)
                    .font(.largeTitle)
                    .bold()
                    .multilineTextAlignment(.center)
                HStack(alignment: .center, spacing: 20){
                    Text("Color")
                        .font(.headline)
                    Text(clothes.color)
                }
                VStack(alignment: .leading, spacing: 30){
                    Text(clothes.description)
                    
                    
                }
                .frame(maxWidth: .infinity, alignment: .leading) //lel description naheha ken thebha fel west
            }
            .padding(.horizontal)
        }
        .ignoresSafeArea(.container, edges: .top)
        //.navigationBarBackButtonHidden(true)

    }
}

struct ClothesDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ClothesDetailView(clothes: Clothes.all[0])
    }
}
