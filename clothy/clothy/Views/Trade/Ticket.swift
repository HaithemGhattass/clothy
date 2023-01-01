//
//  Ticket.swift
//  clothy
//
//  Created by Mohamed Amine Mtar on 29/11/2022.
//

import SwiftUI

struct Ticket: View {
    @State var title = "THOR"
    @State var subtitle = "Love and Thunder"
    @State var top = "thor-top"
    @State var bottom = "thor-bottom"
    @State var taille = "XL"
    @State var color = "#FF0000"
    @Binding var height : CGFloat
    

    var gradient = [Color("cyan"),Color("cyan").opacity(0),Color("cyan").opacity(0)]
    var body: some View {
        VStack(spacing: 0.0){
            VStack(spacing: 4.0){
                Text(title)
                    .fontWeight(.bold)
                Text(subtitle)
                
            }
            .padding(EdgeInsets(top : 20 , leading : 30 , bottom : 0 , trailing : 20))
            .frame(width: 250, height: 325 ,alignment: .top)
            .foregroundColor(.white)
            .background(
                AsyncImage(url: URL(string: HostUtils().HOST_URL + "uploads/outfit/" + bottom )){ image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        
                }
                
                placeholder : {
                    ProgressView()
                        .scaleEffect(5)
                        .font(.system(size:8))
                        .progressViewStyle(CircularProgressViewStyle(tint:Color("lightPurple")))

                      

                }
            )
            .mask(
               
              
                AsyncImage(url: URL(string: HostUtils().HOST_URL + "upload/" + bottom )){ image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        
                }
                
                placeholder : {
                    ProgressView()
                        .scaleEffect(5)
                                       .font(.system(size:8))
                                       .progressViewStyle(CircularProgressViewStyle(tint:Color("lightPurple")))


                }

                
               
            )
            .overlay{
                RoundedRectangle(cornerRadius: 40)
                    .stroke(LinearGradient(colors: gradient, startPoint: .topLeading, endPoint: .bottomTrailing),style: SwiftUI.StrokeStyle(lineWidth: 2))
            }
            .cornerRadius(40 ,corners: [.topLeft, .topRight])
            Spacer(minLength: height)
            
            VStack(spacing: 10.0){
                Line()
                    .stroke(style: SwiftUI.StrokeStyle(lineWidth: 2, dash : [7]))
                    .frame(width: 200 , height: 1)
                    .opacity(0.6)
                HStack(spacing: 20.0){
                    HStack(spacing: 4.0){
                        Text("taille:")
                            .fontWeight(.medium)
                            .foregroundColor(Color("lightPurple"))
                            Text(taille)
                            .foregroundColor(.black)
                    }
                    HStack(spacing: 4.0){
                        Text("color:")
                            .fontWeight(.medium)
                            .foregroundColor(Color("lightPurple"))
                           // Text(color)
                        Circle().fill(Color(hex: color))
                            .frame(width: 20, height: 20)
                            .foregroundColor(.black)
                    }
                    
                    
                }
                HStack(spacing: 20.0){
                    HStack(spacing: 4.0){
                        Text("description:")
                            .fontWeight(.medium)
                            .foregroundColor(Color("lightPurple"))
                            Text("description")
                            .foregroundColor(.black)
                    }

                    
                    
                }
               // Image("code")
            }
            .frame( width : 250 , height : 135 , alignment : .top )
            .background(.ultraThinMaterial)
            .background(
                Image("thor-bottom")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            )
            .mask(
                Image("thor-bottom")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            )
        }
        .frame(height : 460 )
        .font(.footnote)
        .shadow(radius: 10)
    }
}

struct Ticket_Previews: PreviewProvider {
    static var previews: some View {
        Ticket(height : .constant(0))
    }
}
