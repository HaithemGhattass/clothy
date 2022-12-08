//
//  CategorieView.swift
//  clothy
//
//  Created by haithem ghattas on 22/11/2022.
//

import SwiftUI

struct CategoryViewDetails: View {
   
    var categroie : String
   
    @StateObject var ovm = OutfitViewModel()

   var title = "Tshirt"
   var image = "Illustration1"
   var color = Color("background3")
   var shadowColor = Color("backgroundShadow3")

    var categorie = Categorie.Tshirts
    
    var body: some View {
        
        ZStack {
            Color(hex: "F2F6FF").edgesIgnoringSafeArea(.all)
            ScrollView{
                
                
                VStack {
                
//        ForEach(0 ..< 5)
                    ForEach(ovm.clothes,id: \.id)   { clothes in
                            
                        GeometryReader { geo in
                            CardItem(minY: geo.frame(in: .global).minY , clothes: clothes)
                     //       Text("\(geo.frame(in: .global).minY / 1000 + 1)")
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 440)

                    }

                 
                    Spacer()
                }
                .onAppear{
                    ovm.getClothes(categorie: categroie)
                }
                
                
                
                
            }
        }
     
                  
       
      //  .animation(Animation.easeInOut(duration: 0.5), value: offset)
      
        
    }
    
    
}
struct detais: View {
    var clothes : Clothes

var body : some View {
    
   
//    let image = "Illustration1"
    
    let color =  RoundedRectangle(cornerRadius: 30)
        .fill(LinearGradient(gradient: Gradient(stops: [
            .init(color: Color(hex: "D4D1B5"), location: 0),
          //  .init(color: Color(hex: "C850C0"), location: 0.6076923608779907),
            .init(color: Color(hex: "FFFFFF"), location: 1)]),
                             startPoint: UnitPoint(x: 0.5000000291053439, y:1.083161507153998e-8),
                             endPoint: UnitPoint(x: -0.002089660354856915, y: 0.976613295904758)))
        .frame(width: 315,height: 380)
        .shadow(radius: 40, x:0,y:20)
    
  //  let shadowColor = Color("backgroundShadow3")
    VStack(alignment: .leading) {
        
        
        
        HStack {
            Circle()
                .fill(Color.blue)
            .frame(width: 20, height: 20)
            Text(" | ")
            Text(clothes.taille)
        }
       // Spacer()

        Text(clothes.description)
            .font(.title)
            .fontWeight(.bold)
            .foregroundColor(.white)
            .padding(30)
            .lineLimit(4)
        
       // Spacer()
        
//
//        Image(image)
//            .resizable()
//            .renderingMode(.original)
//            .aspectRatio(contentMode: .fit)
//            .frame(width: 315, height: 300)
           
            
    }
   .padding()
    .background(color)
   // .cornerRadius(30)
  //  .frame(width: 246, height: 360)
  //  .shadow(color: shadowColor, radius: 20, x: 0, y: 20)

}
}
struct card: View {
    var photo : String
    @StateObject var vm = UsersViewModel()

var body : some View {
    
   
 //   let title = "Tshirt"
  //  let image = "Illustration1"

    let color = RoundedRectangle(cornerRadius: 30)
        .fill(LinearGradient(gradient: Gradient(stops: [
            .init(color: Color(hex: "0093E9"), location: 0),
           // .init(color: Color(hex: "C850C0"), location: 0.6076923608779907),
            .init(color: Color(hex: "80D0C7"), location: 1)]),
                             startPoint: UnitPoint(x: 0.5000000291053439, y:1.083161507153998e-8),
                             endPoint: UnitPoint(x: -0.002089660354856915, y: 0.976613295904758)))
        .frame(width: 315,height: 400) //440
        .shadow(radius: 40, x:0,y:20)
//    let shadowColor = Color("backgroundShadow3")
    VStack(alignment: .leading) {

       
       AsyncImage(url: URL(string: vm.HOST_URL + "upload/" + photo )){ image in
           image
               .resizable()
               .renderingMode(.original)
               .aspectRatio(contentMode: .fit)
               .frame(width: 300, height: 350)
       }
       placeholder : {
           Image(systemName: "photo")
               .resizable()
               .scaledToFit()
               .frame(width: 40, height: 40, alignment: .center)
               .foregroundColor(.white.opacity(0.7))
               .frame(maxWidth: .infinity, maxHeight: .infinity)
//               .overlay(alignment: .top){ //yomkon nbadel .buttom
//                   Text(clothes.description)
//                       .font(.headline)
//                       .foregroundColor(.white)
//                       .shadow(color: .black, radius: 3, x: 0, y: 0)
//                       .frame(maxWidth: 136)
//                       .padding()
//               }
   }
//   }
//   .frame(width: 160, height: 217, alignment: .top)
//   .background(LinearGradient(gradient: Gradient(colors: [Color(.gray).opacity(0.3),Color(.gray)]), startPoint: .top, endPoint: .bottom))
//   .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
//   .shadow(color: Color.black.opacity(0.3), radius: 15, x: 0, y: 10)
//   .onAppear{
//       ovm.getClothes(categorie: clothes.typee)
//   }

        
        
        
//        Text(title)
//            .font(.title)
//            .fontWeight(.bold)
//            .foregroundColor(.white)
//            .padding(.horizontal,60)
//            .lineLimit(4)
//
//        Spacer()
       
       
       
       
       
        
//
//        Image(image)
//            .resizable()
//            .renderingMode(.original)
//            .aspectRatio(contentMode: .fit)
//            .frame(width: 300, height: 350)
            
           
            
    }
   .padding()
    .background(color)
  //  .cornerRadius(30)
  //  .frame(width: 246, height: 360)
   // .shadow(color: shadowColor, radius: 20, x: 0, y: 20)

}
}

struct CategoryViewDetails_Previews: PreviewProvider {
    static var previews: some View {
        CategoryViewDetails(categroie: "Shoes", ovm: OutfitViewModel(), title: "aaa", image: "a", color: Color.red, shadowColor: Color.black, categorie: Categorie.Outwear)
    }
}

struct CardItem: View {
    @State var showContent = false
    @State var showDetails = false
    @State private var offset: CGFloat = 200.0
    var minY : CGFloat
    var clothes : Clothes

    var body: some View {
        ZStack {
            detais(clothes: clothes)
                .offset(x: showDetails ? -30 : 0)
               // .rotation3DEffect(Angle(degrees:  showDetails ? 0 :20), axis: (x:0,y:10,z:0))
                .animation(Animation.spring(response: 0.6, dampingFraction: 0.6, blendDuration: 0).delay(0.1),value: offset)
            
            
            card(photo: clothes.photo)
                .offset(x:showDetails ? -330 : 0)
                .rotationEffect(Angle(degrees: showDetails ? 10 : 0 ))
                .animation(Animation.spring(response: 0.6, dampingFraction: 0.6, blendDuration: 0),value: offset)
            // .animation(Animation.easeInOut(duration: 0.5), value: offset)
            
          
        }
        .scaleEffect(minY<0 ? minY / 1000 + 1 : 1, anchor: .bottom)
        .rotation3DEffect(Angle(degrees: minY / 100), axis: (x: 10, y: 10, z: 10))
        .padding(.horizontal, 40)
        
        
        //  .sheet(isPresented: self.$showitemcontent) { ClothesDetailView(clothes: s) }
        
        .onTapGesture {
            offset -= 100
            showDetails.toggle()
        }
    }
}
