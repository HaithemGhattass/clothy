//
//  CategoryViewDetails.swift
//  clothy
//
//  Created by haithem ghattas on 18/11/2022.
//

import SwiftUI

struct CategoryViewDetails: View {
    var category : Category
    //computed property
    var clothes : [Clothes] {
        return Clothes.all.filter { $0.category == category.rawValue}
    }
    var body: some View {
        ScrollView{
            MyClothesListView(clothes: clothes) 
        }
    //    .navigationTitle(category.rawValue)
     //   .navigationBarTitle(category.rawValue, displayMode: .inline)

        
    }
}

struct CategoryViewDetails_Previews: PreviewProvider {
    static var previews: some View {
        CategoryViewDetails(category: Category.Shirts)
    }
}
