//
//  CategoriesView.swift
//  clothy
//
//  Created by haithem ghattas on 18/11/2022.
//

import SwiftUI

struct CategoriesView: View {

  
   @State var showContent = false
    @State var s = ""

   var body: some View {
           
      
               VStack {
                   HStack{
                       VStack(alignment: .leading) {
                           Text("Categories")
                               .font(.largeTitle)
                               .fontWeight(.heavy)
                           
                           Text("5 categories")
                               .foregroundColor(.gray)
                       }
                       Spacer()
                   }
                   .padding(.leading, 60.0)
                   
                   ScrollView(.horizontal, showsIndicators: false) {
                       HStack(spacing: 30.0) {
                           content
                               .sheet(isPresented: self.$showContent) {
                                   CategoryViewDetails(categroie:s)
                                  // CategoryViewDetails()
                               }
                         
                       }
                       .padding(.leading, 30)
                       .padding(.top, 30)
                     //  .padding(.bottom, 70)
                       Spacer()
                   }
                   
               
             
           }
               
               .offset(y: -30)

       
   }
    
    
}

extension CategoriesView {
    var content: some View {
        ForEach(CategorieItems) { item in
           

                GeometryReader { geometry in
                    CategorieView(title: item.title,
                                 // image: item.image,
                                  color: item.color,
                                  shadowColor: item.shadowColor, categorie: item.categorie)
                    .onTapGesture {
                        s = item.title
                        print(item.title)
                        showContent.toggle()
                    }
                  
                   
                    .rotation3DEffect(Angle(degrees:
                                                Double(geometry.frame(in: .global).minX - 30) / -40), axis: (x: 0, y: 10.0, z: 0))
                }
                .frame(width: 246, height: 360)
            
           
            
        }


       
    }
    
}





struct CategorieItem: Identifiable {
   var id = UUID()
   var title: String
  // var image: String
   var color: Color
   var shadowColor: Color
    var categorie : Categorie
}
enum Categorie: String {
    case Outwear
    case Tshirts
    case Pants
    case Shoes
    case Hats
}


var CategorieItems =  [
      
        CategorieItem(title: "outwear",
                 //     image: "Illustration2",
                      color: Color("background4"),
                      shadowColor: Color("backgroundShadow4"),
                      categorie: .Outwear),
        CategorieItem(title: "t-shirt",
                 //     image: "Illustration1",
                      color: Color("background3"),
                      shadowColor: Color("backgroundShadow3"),
                      categorie: .Tshirts),

        CategorieItem(title: "pants",
                  //    image: "Illustration3",
                      color: Color("background7"),
                      shadowColor: Color(hue: 0.677, saturation: 0.701, brightness: 0.788, opacity: 0.5),
                      categorie: .Pants),

        CategorieItem(title: "shoes",
                   //   image: "Illustration4",
                      color: Color("background8"),
                      shadowColor: Color(hue: 0.677, saturation: 0.701, brightness: 0.788, opacity: 0.5),
                      categorie: .Shoes),

        CategorieItem(title: "hat",
                //      image: "Illustration5",
                      color: Color("background9"),
                      shadowColor: Color(hue: 0.677, saturation: 0.701, brightness: 0.788, opacity: 0.5),
                      categorie: .Hats)
    ]





struct CategoriesView_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesView()
    }
}
