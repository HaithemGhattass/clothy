//
//  TicketView.swift
//  clothy
//
//  Created by Mohamed Amine Mtar on 29/11/2022.
//

import SwiftUI

struct TradeView: View {

    @State var animate = false
    var body: some View {
        ZStack{

            VStack(spacing: 30.0){
                Text("OutFit for Trade")
                    .font(.title3)
                   // .foregroundColor(.black)
                    .fontWeight(.bold)
                Text("Swipe left to ignore , Swipe right to Like")
                    .frame(maxWidth : 248)
                    .font(.body)
                 //   .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                
                
            }
            .padding(.horizontal,20)
             .frame(maxWidth : .infinity, maxHeight : .infinity, alignment : .top)
            Tickets()
                .padding(.top , 30)
        }        .background(
            Image("Blob 1")
                .offset(x: 250 , y: -100)
        )
      
    }
}

struct TradeView_Previews: PreviewProvider {
    static var previews: some View {
        TradeView()
    }
}

