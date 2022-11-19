//
//  OnBoardingView.swift
//  clothy
//
//  Created by haithem ghattas on 3/11/2022.
//

import SwiftUI
import RiveRuntime

struct OnboardingView: View {
    let button = RiveViewModel(fileName: "button")
    @State var showModal = false
    @State var showSignUp = false
    @State var forgetpw = false
    @State var title = "Choose Your Outfit Wisely"
    

    @Binding var show: Bool

    
   
    var body: some View {
        ZStack {
            background
            
            content
                .offset(y: showModal ? -50 : 0)
            
            Color("Shadow")
                .opacity(showModal ? 0.4 : 0)
               .ignoresSafeArea()
            
            if showModal {
                
                SignInView(forgetpw: $forgetpw, showModal: $showModal, showSignUp: $showSignUp, show: $show)
                    .transition(.move(edge: .top).combined(with: .opacity))
                    .overlay(
                        Button {
                            withAnimation(.spring()) {
                                showModal = false
                              
                                
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
            if showSignUp {
                SignUpView( showSignUp: $showSignUp)
                    .transition(.move(edge: .top).combined(with: .opacity))
                    .overlay(
                        Button {
                            withAnimation(.spring()) {
                                showSignUp = false
                              //  showModal = true

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
            if forgetpw {
                ForgotPWView( forgetpw: $forgetpw)
                    .transition(.move(edge: .top).combined(with: .opacity))
                    .overlay(
                        Button {
                            withAnimation(.spring()) {
                              
                            
                                forgetpw = false
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
            // CLOSE BUTTON ( NO NEEDED)
            
         /*
            Button {
                withAnimation {
                    show = false
                }
            } label: {
                Image(systemName: "xmark")
                    .frame(width: 36, height: 36)
                    .background(.black)
                    .foregroundColor(.white)
                    .mask(Circle())
                    .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 10)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
            .padding(20)
            .offset(y: showModal ? -200 : 80)
          */
        }
    }
    
    var content: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(title)
                .font(.custom("Poppins Bold", size: 60, relativeTo: .largeTitle))
                .frame(width: 260, alignment: .leading)
            
            Text("Clothy can choose the right outfit for you with a simple press, also here you can trade your clothes safely.")
                .customFont(.body)
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
                            showModal = true
                        }
                    }
            }
            
            Text("©Haithem&mtar.")
                .customFont(.footnote)
                .opacity(0.7)
        }
        .padding(40)
        .padding(.top, 40)
    }
    
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

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView(show: .constant(true))
    }
}
