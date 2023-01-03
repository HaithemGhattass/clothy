//
//  SuggestionItem.swift
//  Clothy
//
//  Created by haithem ghattas on 29/11/2022.
//

import SwiftUI

struct SuggestionItem: View {
    var namespace : Namespace.ID
    @Binding var show : Bool
    var body: some View {
        VStack {
            Spacer()
            VStack(alignment: .leading, spacing: 12) {
                Text("choose Your outfit")
                    .font(.largeTitle.weight(.bold))
                    .matchedGeometryEffect(id: "title", in: namespace)
                .frame(maxWidth: .infinity,alignment: .leading)
                Text("let clothyy help".uppercased())
                    .font(.footnote.weight(.semibold))
                    .matchedGeometryEffect(id: "subtitle", in: namespace)
                Text("let clothy choose for you")
                    .font(.footnote)
                    .matchedGeometryEffect(id: "text", in: namespace)

            }
            .padding(20)
            .background(
                Rectangle()
                    .fill(.ultraThinMaterial)
                    .mask(RoundedRectangle(cornerRadius: 30,style: .continuous))
                    .blur(radius: 30)
                    .matchedGeometryEffect(id: "blur", in: namespace)
            )
            
        }
        
        .foregroundStyle(.white)
        .background(
            Image("Illustration 9")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .matchedGeometryEffect(id: "image", in: namespace)
        )
        .background(
            Image("Background 5")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .matchedGeometryEffect(id: "background", in: namespace)
        )
      
        .mask(
            RoundedRectangle(cornerRadius: 30,style: .continuous)
                .matchedGeometryEffect(id: "mask", in: namespace)
        )
        .frame(height: 300)
        .padding(20)
    }
}

struct SuggestionItem_Previews: PreviewProvider {
    @Namespace static var namespace
    static var previews: some View {
        SuggestionItem(namespace: namespace, show: .constant(true))
    }
}
