//
//  ContentView.swift
//  ClothyApp
//
//  Created by haithem ghattas on 15/12/2022.
//

import SwiftUI
import RiveRuntime

struct ContentView: View {
    let button = RiveViewModel(fileName: "button")
    @State var showsignin = false
    @State var forgetpw = false
    @State var showSignUp = false
    @State var logged = false
    
 
    
    var body: some View {
        
        if (!logged){
            ZStack {
                background
                content
                    .offset(y: showsignin ? -50 : 0)
                Color("Shadow")
                    .opacity(showsignin || showSignUp || forgetpw ? 0.4 : 0)
                    .ignoresSafeArea()
                if showsignin {
                    SignInView(logged: $logged, forgetpw: $forgetpw, showSignUp: $showSignUp, showsignin : $showsignin)
                        .transition(.move(edge: .top).combined(with: .opacity))
                        .overlay(
                            Button {
                                withAnimation(.spring()) {
                                    showsignin.toggle()
                                }
                            } label: {
                                Image(systemName: "xmark")
                                    .frame(width: 36, height: 36)
                                    .foregroundColor(.black)
                                    .background(.white)
                                    .mask(Circle())
                                    .shadow(color: Color("Shadow").opacity(0.3), radius: 5, x: 0, y: 3)
                            }
                                .frame(maxHeight: .infinity, alignment: .bottom)
                        )
                        .zIndex(1)
                    
                }
                if forgetpw{
                    
                    ForgetPasswordView(showSignIn: $showsignin, forgetpw: $forgetpw)
                        .transition(.move(edge: .top).combined(with: .opacity))
                        .overlay(
                            Button {
                                withAnimation(.spring()) {
                                    forgetpw.toggle()
                                    showsignin.toggle()
                                    
                                }
                            } label: {
                                Image(systemName: "xmark")
                                    .frame(width: 36, height: 36)
                                    .foregroundColor(.black)
                                    .background(.white)
                                    .mask(Circle())
                                    .shadow(color: Color("Shadow").opacity(0.3), radius: 5, x: 0, y: 3)
                            }
                                .frame(maxHeight: .infinity, alignment: .bottom)
                        )
                        .zIndex(1)
                    
                }
                if showSignUp{
                    SignUpView(showSignUp: $showSignUp, showSignIn: $showsignin)
                        .transition(.move(edge: .top).combined(with: .opacity))
                        .overlay(
                            Button {
                                withAnimation(.spring()) {
                                    showsignin.toggle()
                                    showSignUp.toggle()
                                    
                                }
                            } label: {
                                Image(systemName: "xmark")
                                    .frame(width: 36, height: 36)
                                    .foregroundColor(.black)
                                    .background(.white)
                                    .mask(Circle())
                                    .shadow(color: Color("Shadow").opacity(0.3), radius: 5, x: 0, y: 3)
                            }
                                .frame(maxHeight: .infinity, alignment: .bottom)
                        )
                        .zIndex(1)
                    
                }
                
            }
        }
        if (logged){
            MainView()
        }
    }

    //MARK: Content
    var content: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Choose Your Outfit Wisely")
                .font(.headline).bold()
                .frame(width: 260, alignment: .leading)
            
            Text("Clothy can choose the right outfit for you with a simple press, also here you can trade your clothes safely.")
                .font(.body).bold()
            
                .opacity(0.7)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Spacer()
            
            button.view()
                .frame(width: 236, height: 64)
                .overlay(
                    Label("Start with Clothy", systemImage: "arrow.forward")
                        .offset(x: 4, y: 4)
                        .font(.headline)
                    
                    
                )
                .background(
                    Color.black
                        .cornerRadius(30)
                        .blur(radius: 10)
                        .opacity(0.3)
                        .offset(y: 10)
                )
                .onTapGesture {
                    button.play(animationName: "active")
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                        withAnimation(.spring()) {
                            showsignin.toggle()
                        }
                    }
                }
            
            
            
            
            Text("©Haithem&mtar.")
                .font(.footnote)
                .opacity(0.7)
        }
        .padding(40)
        .padding(.top, 40)
    }
    //MARK: background
    var background: some View {
        RiveViewModel(fileName: "shapes").view()
            .ignoresSafeArea()
            .blur(radius: 30)
            .background(
                Image("Spline")
                    .blur(radius: 50)
                    .offset(x: 200, y: 100)
            )
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
            ContentView()
                .preferredColorScheme(.dark)
                .previewDevice("iPhone 13 mini")
        }
        
    }

}

