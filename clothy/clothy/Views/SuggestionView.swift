//
//  SuggestionView.swift
//  Clothy
//
//  Created by haithem ghattas on 29/11/2022.
//

import SwiftUI

struct SuggestionView: View {
    var namespace : Namespace.ID
    @StateObject private var weatherAPIClient = WeatherAPIClient()

    @Binding var show : Bool
    @State var appear = [false,false,false]
    @EnvironmentObject var model : Model
    @State var viewstate : CGSize = .zero
    @State var isDraggable = true
    @State var formulaire = true
    var body: some View {
        ZStack {
            ScrollView {
                cover
               
                
            }
            .background(Color("Background"))
            .mask(RoundedRectangle(cornerRadius: viewstate.width / 3 ,style: .continuous))
            .shadow(color: .black.opacity(0.3), radius: 30 , x: 0 , y: 10)
            .scaleEffect(viewstate.width / -500 + 1)
            .background(.black.opacity(viewstate.width / 500))
            .background(.ultraThinMaterial)
            .gesture( isDraggable ? drag : nil)
            .ignoresSafeArea()
            button
        }
        .onAppear{
            fadeIn()
            
        }
        .onChange(of: show) { newValue in
            fadeOut()
            
        }
    }
    
    var cover: some View {
        GeometryReader { proxy in
            let scrollY = proxy.frame(in: .global).minY
            VStack {
                Spacer()
            }
            .frame(maxWidth: .infinity)
            
            .frame(height: scrollY > 0 ? 500 + scrollY : 500)
            .foregroundStyle(.black)
            .background(
                Image("Illustration 9")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .matchedGeometryEffect(id: "image", in: namespace)
                    .offset(y: scrollY > 0 ? scrollY * -0.8 : 0)
            )
            .background(
                Image("Background 5")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .matchedGeometryEffect(id: "background", in: namespace)
                    .offset(y: scrollY > 0 ? -scrollY : 0)
                    .scaleEffect(scrollY > 0 ? scrollY / 1000 + 1 : 1)
                    .blur(radius: scrollY / 10)
            )
            .mask(
                RoundedRectangle(cornerRadius: 30,style: .continuous)
                    .matchedGeometryEffect(id: "mask", in: namespace)
                    .offset(y: scrollY > 0 ? -scrollY : 0)
            )
            .overlay(
                    overlayContent
                        .offset(y: scrollY > 0 ? scrollY * -0.6 : 0)

        )
            
        }
        .frame(height: 500)
    }
   
    var button : some View {
        Button {
            withAnimation(.closeCard){
                show.toggle()
                model.showsuggestion.toggle()
            }
        } label: {
            Image(systemName: "xmark")
                .font(.body.weight(.semibold))
                .foregroundColor(.secondary)
                .padding(8)
                .background(.ultraThinMaterial, in : Circle())
        }
        .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .topTrailing)
        .padding(20)
        .ignoresSafeArea()
    }
    var formulaireContent : some View {
        VStack(alignment: .leading, spacing: 12){
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
            
            
            Divider()
                .opacity(appear[0] ? 1 : 0)
            HStack {
                Image("Avatar Default")
                    .resizable()
                    .frame(width: 26,height: 26)
                    .cornerRadius(10)
                    .padding(8)
                    .background(.ultraThinMaterial, in :
                                    RoundedRectangle(cornerRadius: 18,style: .continuous))
                    .strokeStyle(cornerRadius: 18)
                Text("weather today is ")
                    .font(.footnote)
            }
            .opacity(appear[1] ? 1 : 0)
            Divider()
                .opacity(appear[0] ? 1 : 0)
            HStack {
                Image("Avatar Default")
                    .resizable()
                    .frame(width: 26,height: 26)
                    .cornerRadius(10)
                    .padding(8)
                    .background(.ultraThinMaterial, in :
                                    RoundedRectangle(cornerRadius: 18,style: .continuous))
                    .strokeStyle(cornerRadius: 18)
                Text("what are out plans for today ")
                    .font(.footnote)
                    .onTapGesture {
                        formulaire.toggle()
                        
                    }
            }
        }
            .padding(20)
            .background(
                Rectangle()
                    .fill(.ultraThinMaterial)
                    .mask(RoundedRectangle(cornerRadius: 30,style: .continuous))
                    .matchedGeometryEffect(id: "blur", in: namespace)
            )
            .offset(y:250)
            .padding(20)
    }
    var overlayContent : some View {
        
            VStack(alignment: .leading, spacing: 12){
                Text(formulaire ? "Tell us more" :  "choose Your outfit" )
                    .font(.largeTitle.weight(.bold))
                    .matchedGeometryEffect(id: "title", in: namespace)
                    .frame(maxWidth: .infinity,alignment: .leading)
                Text("let clothyy help".uppercased())
                    .font(.footnote.weight(.semibold))
                    .matchedGeometryEffect(id: "subtitle", in: namespace)
                Text("let clothy choose for you")
                    .font(.footnote)
                    .matchedGeometryEffect(id: "text", in: namespace)
                
                
                Divider()
                    .opacity(appear[0] ? 1 : 0)

                    HStack(alignment: .center, spacing: 10) {
                                Spacer()
                                if let currentWeather = weatherAPIClient.currentWeather  {
                                    HStack(alignment: .center, spacing: 16) {
                                        currentWeather.weatherCode.image
                                            .font(.largeTitle)
                                        Text("\(currentWeather.temperature)º")
                                            .font(.largeTitle)
                                    }
                                    Text(currentWeather.weatherCode.description)
                                        .font(.body)
                                        .multilineTextAlignment(.center)
                                } else {
                                    Text("No weather info available yet.\nTap on refresh to fetch new data.\nMake sure you have enabled location permissions for the app.")
                                        .font(.body)
                                        .multilineTextAlignment(.center)
                                    Button("Refresh", action: {
                                        Task {
                                            await weatherAPIClient.fetchWeather()
                                        }
                                    })
                                }
                                Spacer()
                            }
                            .onAppear {
                                Task {
                                    await weatherAPIClient.fetchWeather()
                                }
                            }
                
                .opacity(appear[1] ? 1 : 0)
                Divider()
                    .opacity(appear[0] ? 1 : 0)
                VStack{
                    HStack {
                        Image("Avatar Default")
                            .resizable()
                            .frame(width: 26,height: 26)
                            .cornerRadius(10)
                            .padding(8)
                            .background(.ultraThinMaterial, in :
                                            RoundedRectangle(cornerRadius: 18,style: .continuous))
                            .strokeStyle(cornerRadius: 18)
                        
                        Text("what are out plans for today ")
                            .font(.footnote)
                            .onTapGesture {
                                formulaire.toggle()
                            }
                    }
                    HStack(alignment:  .center, spacing: 30 ){
                        Divider().hidden()
                        Button{
                            //MARK: CHILLING
                        }label: {
                            Text("Chilling")
                        }
                        Button{
                            //MARK: Date
                        }label: {
                            Text("Date")
                        }
                        Button{
                            //MARK: Work
                        }label: {
                            Text("Work")
                        }
                        Button{
                            //MARK: SPORT
                        }label: {
                            Text("Sport")
                        }
                    }
                 
                }
            }
                .padding(20)
                .background(
                    Rectangle()
                        .fill(.ultraThinMaterial)
                        .mask(RoundedRectangle(cornerRadius: 30,style: .continuous))
                        .matchedGeometryEffect(id: "blur", in: namespace)
                )
                .offset(y:250)
                .padding(20)
        
    }
    var drag : some Gesture {
        
            DragGesture(minimumDistance: 30 , coordinateSpace: .local).onChanged{ value in
                guard value.translation.width > 0 else {return}
                
                if value.startLocation.x < 100 {
                    withAnimation(.closeCard){
                        viewstate = value.translation

                    }
                }
                if viewstate.width > 120 {
                    close()
                }
            }
                .onEnded{ value in
                    
                    if viewstate.width > 80 {
                      close()
                    } else {
                        withAnimation(.closeCard){
                            viewstate = .zero

                        }
                    }
                  
                    
                }
        
    }
    func fadeIn() {
        withAnimation(.easeOut.delay(0.3)){
            appear[0] = true
            
        }
        withAnimation(.easeOut.delay(0.4)){
            appear[1] = true
            
        }
        withAnimation(.easeOut.delay(0.5)){
            appear[2] = true
        }
    }
    func fadeOut() {
        appear[0] = false
        appear[1] = false
        appear[2] = false
    }
    func close() {
        
            withAnimation(.closeCard.delay(0.3)){
                show.toggle()
                model.showsuggestion.toggle()
            }
        
        withAnimation(.closeCard){
            viewstate = .zero

        }
        isDraggable = false
    }
}

struct SuggestionView_Previews: PreviewProvider {
    @Namespace static var namespace
    static var previews: some View {
        SuggestionView(namespace: namespace, show: .constant(true))
            .environmentObject(Model())
    }
}
