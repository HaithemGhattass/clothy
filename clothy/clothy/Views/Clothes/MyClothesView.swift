//
//  MyClothesView.swift
//  clothy
//
//  Created by haithem ghattas on 18/11/2022.
//

import SwiftUI

struct MyClothesView: View {
    var body: some View {
        
        NavigationView {
            ScrollView{
                MyClothesListView(clothes: Clothes.all)

            }
            .navigationTitle("My Clothes")
        }
        .navigationViewStyle(.stack)
    }
}

struct MyClothesView_Previews: PreviewProvider {
    static var previews: some View {
        MyClothesView()
    }
}
