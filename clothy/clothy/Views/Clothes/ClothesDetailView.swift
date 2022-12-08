//
//  ClothesDetailView.swift
//  clothy
//
//  Created by haithem ghattas on 18/11/2022.
//

import SwiftUI

struct ClothesDetailView: View {
    var clothes : Clothes
    var vm = UsersViewModel()
    var ovm = OutfitViewModel()
    var body: some View {
        ScrollView {
            AsyncImage(url: URL(string: vm.HOST_URL + "upload/" + clothes.photo)){ image in
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
                Text(clothes.description)
                    .font(.largeTitle)
                    .bold()
                    .multilineTextAlignment(.center)
                HStack(alignment: .center, spacing: 20){
                    Text("Color")
                        .font(.headline)
                    Text(clothes.couleur)
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
        ClothesDetailView(clothes: Clothes(typee: "a", couleur: "a", photo: "a", userID: "a", taille: "a", description: "a", id: "a", createdAt: "a", updatedAt: "a", v: 2))
    }
}
