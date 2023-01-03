//
//  MatchedItemsView.swift
//  clothy
//
//  Created by haithem ghattas on 2/1/2023.
//

import SwiftUI

struct MatchedItemsView: View {
    @State var type : String
    @State var taille : String
    @State var couleur : String
    @State var image : String
    @State var id : String

    var body: some View {
        

                   
        VStack(alignment: .leading, spacing : 8.0) {
            HStack {
                
                AsyncImage(url: URL(string: HostUtils().HOST_URL + "uploads/" + image)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 100)
                        .padding(.leading)
                    
                } placeholder: {
                    ProgressView()
                }
                VStack{
                    Spacer()
                    
                    Text(type)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundStyle(.linearGradient(colors: [.primary,.primary.opacity(0.5)], startPoint: .topLeading, endPoint: .bottomTrailing))
                    Text(taille.uppercased())
                        .font(.footnote)
                        .fontWeight(.semibold)
                        .foregroundStyle(.secondary)
                    Circle().fill(Color(hex: couleur))
                        .frame(width: 30, height: 30)
                }
                
            }
           
            .padding(/*@START_MENU_TOKEN@*/.all, 20.0/*@END_MENU_TOKEN@*/)
            .padding(.vertical,20)
            .frame(height: 150)
            .background(.ultraThinMaterial)
            .mask(RoundedRectangle(cornerRadius: 30,style: .continuous))
            // .cornerRadius(30)
            //.mask(RoundedRectangle(cornerRadius: 30,style: .continuous))
            .strokeStyle()
            .padding(.horizontal, 20)
           
        }
       
        
    }
       
       
}

struct MatchedItemsView_Previews: PreviewProvider {
    static var previews: some View {
        MatchedItemsView(type: "T-shirt", taille: "S", couleur: "red",image: "image",id:"234")
    }
}
