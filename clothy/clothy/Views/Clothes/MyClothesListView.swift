//
//  MyClothesListView.swift
//  clothy
//
//  Created by haithem ghattas on 18/11/2022.
//

import SwiftUI

struct MyClothesListView: View {
    var clothes: [Clothes]
    var body: some View {
        VStack {
            HStack {
                Text("\(clothes.count)\(clothes.count > 1 ? " Clothes" : " cloth")")
                    .font(.headline)
                    .fontWeight(.medium)
                    .opacity(0.7)
                Spacer()
            }
      
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 160), spacing: 15)], spacing: 15 ) {
            ForEach(clothes) { clothes in
                NavigationLink(destination: ClothesDetailView(clothes: clothes)){
                    ClothesCard(clothes: clothes)
                }
            }
        }
        .padding(.top)
    }
        .padding(.horizontal)
        //.navigationBarBackButtonHidden(true)

    }
}
      


struct MyClothesListView_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView{
            MyClothesListView(clothes: Clothes.all)

        }
    }
}
