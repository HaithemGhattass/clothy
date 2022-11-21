//
//  CategoriesView.swift
//  clothy
//
//  Created by haithem ghattas on 18/11/2022.
//

import SwiftUI

struct CategoriesView: View {
    var body: some View {
        NavigationView {
            List{
                ForEach(Category.allCases ) { category in
                    NavigationLink{
                      CategoryViewDetails(category: category)
                    }label: {
                        Text(category.rawValue )
                    }
                  
                }
                NavigationLink{
                        AddClothesCameraView(sourceType:.photoLibrary , classifier: ImageClassifier())
                    
                }label: {
                    Text("add clothes")
                    
                }

            }
            .navigationBarTitle("Categories", displayMode: .inline)
            
           
            
        }
        .navigationViewStyle(.stack)
       
        
    }
}


struct CategoriesView_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesView()
    }
}
