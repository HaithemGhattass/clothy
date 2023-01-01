//
//  SearchView.swift
//  clothy
//
//  Created by Mohamed Amine Mtar on 19/12/2022.
//

import SwiftUI

struct Search: View {
    
    @Binding var searchText: String
    
    var body: some View {
        VStack{

                HStack {
                    Image(systemName: "magnifyingglass")
                    
                    TextField("Search", text: $searchText)
                        .foregroundColor(.primary)
                    
                    Button(action: {
                        self.searchText = ""
                    }) {
                        Image(systemName: "xmark.circle.fill").opacity(searchText == "" ? 0 : 1)
                    }
                }
                .padding(15)
                .foregroundColor(.secondary)
                .background(Color("color_bg_inverted").opacity(0.05))
                .clipShape(Capsule())
            
        }
        .padding(.vertical)
    }
}
