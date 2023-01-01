//
//  NavigationBar.swift
//  Clothy
//
//  Created by haithem ghattas on 29/11/2022.
//

import SwiftUI

struct NavigationBar: View {
    var title = ""
    @Binding var hasScrolled : Bool
    @State var showSearch = false
    @State var showAccount = false
    var body: some View {
        ZStack {
            Color.clear
                .background(.ultraThinMaterial)
                .blur(radius: 10)
                .opacity(hasScrolled ? 1 : 0)
            
             Text(title)
                
                .animatableFont(size: hasScrolled ? 22 : 34, weight: .bold)
            .frame(maxWidth: .infinity , alignment: .leading)
            .padding(
                .leading,20)
            .padding(.top,20)
            .offset(y: hasScrolled ? -4 : 0)

            HStack(spacing: 16 ) {
         
                Button{
                    showAccount = true
                }
                label :{
                    Image("Avatar Default")
                        .resizable()
                        .frame(width: 26, height: 26)
                        .cornerRadius(10)
                        .padding(8)
                        .background(.ultraThinMaterial, in :
                                        RoundedRectangle(cornerRadius: 18 ,style: .continuous ))
                    .strokeStyle(cornerRadius: 18)
                }
                .sheet(isPresented: $showAccount) {
                    AccountView()
                }
            }
            .frame(maxWidth: .infinity,alignment: .trailing )
            .padding(.trailing , 20)
            .padding(.top, 20)
            .offset(y: hasScrolled ? -4 : 0)
        }
        .frame(height: hasScrolled ? 44 : 70)
            .frame(maxHeight: .infinity,alignment: .top )
    }
}

struct NavigationBar_Previews: PreviewProvider {
    static var previews: some View {
        NavigationBar(title: "home", hasScrolled: .constant(false))
    }
}
