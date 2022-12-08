//
//  HomeView.swift
//  Clothy
//
//  Created by haithem ghattas on 29/11/2022.
//

import SwiftUI

struct HomeView: View {
    @State var hasScrolled = false
    @Namespace var namespace
    @State var show = false
    @State var showcloset = false
    @State var showstatusbar = true
    @State var selectedcloset: Closet = closets[0]

    
    @EnvironmentObject var model : Model
    var body: some View {
        ZStack {
            Color("Background").ignoresSafeArea()
            ScrollView {
          scrollDetection
             featured
                Text("Suggestions".uppercased())
                    .font(.footnote.weight(.semibold))
                    .foregroundColor(.secondary)
                    .frame(maxWidth: .infinity,alignment: .leading)
                    .padding(.horizontal,20)
                if !show {
                
                    suggestionCard
                }
            }
            .coordinateSpace(name: "scroll")
          
            .safeAreaInset(edge: .top, content: {
                Color.clear.frame(height: 70 )
            })
            .overlay(
                NavigationBar(title: "Home", hasScrolled: $hasScrolled)
                
        )
            if show {
                suggestion

            }
        }
        .statusBar(hidden: !showstatusbar)
        .onChange(of: show){ newValue in
            withAnimation(.closeCard){
                if newValue {
                    showstatusbar = false
                } else {
                    showstatusbar = true
                }
            }
         
        }
    }
    var scrollDetection : some View {
        GeometryReader{ proxy in
        //    Text("\(proxy.frame(in: .named("scroll")).minY)")
            Color.clear.preference(key: ScrollPrefrenceKey.self,value: proxy.frame(in: .named("scroll")).minY)
            
        }
        .frame(height: 0)
        .onPreferenceChange(ScrollPrefrenceKey.self,perform: { value in
            withAnimation(.easeInOut){
                if value < 0{
                    hasScrolled = true
                }else {
                    hasScrolled = false
                }
            }
          
                
            
        })
    }
    var featured : some View {
        TabView {
            ForEach(closets) { closet in
                GeometryReader { proxy in
                    let minX = proxy.frame(in: .global).minX
                    FeaturedItem(closet: closet)
                        .padding(.vertical, 40)
                        .rotation3DEffect(.degrees(minX / -10), axis: (x: 0, y: 1, z: 0))
                        .shadow(color: Color("Shadow").opacity(0.3), radius: 10, x: 0, y: 10)
                        .offset(x: abs(minX / 40))
                        .blur(radius: minX)
                        .overlay(
                            Image(closet.image)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 230)
                                .offset(x: 32 , y: -80)
                                .offset(x: minX / 2)
                    )
                        .padding(20)
                        .onTapGesture {
                            showcloset = true
                            selectedcloset = closet
                        }

                   // Text("\(proxy.frame(in: .global).minX)")
                }
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .frame(height: 430)
        .background(
            Image("Blob 1")
                .offset(x: 250 , y: -100)
        )
        .sheet(isPresented: $showcloset) {
            CategoryViewDetails(categroie: selectedcloset.title)
                //Text(selectedcloset.title)
        }
    }
    var suggestionCard : some View {
        SuggestionItem(namespace: namespace, show: $show)
            .onTapGesture {
                withAnimation(.openCard){
                    show.toggle()
                    model.showsuggestion.toggle()
                    showstatusbar = false

                }
            }
    }
    var suggestion : some View {
        SuggestionView(namespace: namespace, show: $show)
            .zIndex(1)
            .transition(.asymmetric(insertion: .opacity.animation(.easeInOut(duration: 0.1)), removal: .opacity.animation(.easeInOut(duration: 0.3).delay(0.2))))
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(Model())
    }
}
