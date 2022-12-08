//
//  ContentView.swift
//  clothy
//
//  Created by haithem ghattas on 3/11/2022.
//

import SwiftUI
import RiveRuntime

struct ContentView: View {
    @AppStorage("selectedTab")  var selectedTab: Tab = .home
    @EnvironmentObject var model : Model

   // @State var isOpen = false
    @State var show = true
    @StateObject var loginVM = LoginViewModel()
    @StateObject var vm = UsersViewModel()
    @State var users = [User] ()
    @State var hide = false

    let button = RiveViewModel(fileName: "menu_button", stateMachineName: "State Machine", autoPlay: false)
    var body: some View {
        
        
              if (!show){
              //    Color("Background 2").ignoresSafeArea()
                  
                  
                  ZStack(alignment: .bottom) {
                      
                      
                     
                          switch selectedTab {
                          case .home:
                              HomeView()
                          case .profile:
                              AccountView()
                          case .add:
                              AddClothesCameraView(sourceType: .photoLibrary, classifier: ImageClassifier())
                              
                          case .trade:
                            //  AccountView()
                              TicketView()
                          case .chat:
                              ChatView()
                              
                          }
                      
                      
                      TabBar()
                          .offset(y:model.showsuggestion ? 200 : 0)
                      
                  }
                  .safeAreaInset(edge: .bottom){
                      Color.clear.frame(height: 44)
                  }
                 
              }
        
                  if(show){
                      OnboardingView(show: $show)
                          .background(.white)
                          .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
                          .shadow(color: .black.opacity(0.5), radius: 40, x: 0, y: 40)
                          .ignoresSafeArea()
                      
                      // uncomment for some offset  .ignoresSafeArea(.all, edges: .top)
                          .transition(.move(edge: .top))
                      //   .offset(y: show ? -10 : 0)
                          .zIndex(1)
                  }
        

        
    
        
        
      
            //}
            
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(Model())
    }
}
