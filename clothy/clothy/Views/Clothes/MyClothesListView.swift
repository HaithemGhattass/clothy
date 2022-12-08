//
//  MyClothesListView.swift
//  clothy
//
//  Created by haithem ghattas on 18/11/2022.
//

import SwiftUI

struct MyClothesListView: View {
   // var clothes: [Clothes]
    var categroie : String
   
    @StateObject var ovm = OutfitViewModel()

    @State var showitemcontent = false
    var body: some View {
       
        VStack {
            HStack {
               Text("items")
                  .font(.largeTitle)
                  .fontWeight(.heavy)

               Spacer()
            }
            HStack {
                Text("Clothes")
                    .font(.headline)
                    .fontWeight(.medium)
                    .opacity(0.7)
                    .foregroundColor(.gray)
                Spacer()
            }
      
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 160), spacing: 15)], spacing: 15 ) {
            ForEach(ovm.clothes,id: \.id) { clothes in
                    let s = clothes
                    ClothesCard(clothes: clothes)
                  
                    .sheet(isPresented: self.$showitemcontent) { ClothesDetailView(clothes: s) }
                    .onTapGesture {
                        showitemcontent.toggle()
                    }


            }
            
            
//            ForEach(ovm.clothes,id: \.id) { clothes in
//
//
//                    VStack(alignment: .leading) {
//                        Text("First Name")
//                            .customFont(.subheadline)
//                            .foregroundColor(.secondary)
//                        TextField(user.pseudo, text: $pseudo)
//                            .customTextField(image: Image(""))
//                    }
//                    TextField(user.pseudo,text: $pseudo)
                    

                   

                    
        }
        .onAppear{
            ovm.getClothes(categorie: categroie)
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
            MyClothesListView(categroie: "Tshirts")

        }
    }
}
