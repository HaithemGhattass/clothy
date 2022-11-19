//
//  ContentView.swift
//  clothy
//
//  Created by haithem ghattas on 3/11/2022.
//

import SwiftUI
import RiveRuntime

struct ContentView: View {
    @AppStorage("selectedTab") var selectedTab: Tab = .chat
    @State var isOpen = false
    @State var show = true
    @StateObject var loginVM = LoginViewModel()
    @StateObject var vm = UsersViewModel()
    @State var users = [User] ()
    @State var hide = false

    let button = RiveViewModel(fileName: "menu_button", stateMachineName: "State Machine", autoPlay: false)
    var body: some View {
        ZStack {
            if (!show){
                Color("Background 2").ignoresSafeArea()
                //   Color.white.ignoresSafeArea()
                
                
                
                SideMenu()
                    .opacity(isOpen ? 1 : 0)
                    .offset(x: isOpen ? 0 : -300)
                    .rotation3DEffect(.degrees(isOpen ? 0 : 30), axis: (x: 0, y: 1, z: 0))
                    .onAppear(perform:
                                vm.fetchuser
                    )
                //   .onAppear(perform: loginVM.fetchuser)
                
                
                
                // .onAppear(perform: loginVM.fetchuser)
                
                Group {
                    switch selectedTab {
                    case .chat:
                        Text("chat")
                    case .search:
                        CategoriesView()
                            .background(.white)
                    case .timer:
                        Text("Timer")
                    case .bell:
                        Text("Bell")
                    case .user:
                        
                        ProfileView()
                            .background(.white)
                            
                        
                    }
                }
                .safeAreaInset(edge: .bottom) {
                    Color.clear.frame(height: 80)
                }
                .safeAreaInset(edge: .top) {
                    Color.clear.frame(height: 104)
                }
                .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
                .rotation3DEffect(.degrees(isOpen ? 30 : 0), axis: (x: 0, y: -1, z: 0))
                .offset(x: isOpen ? 265 : 0)
                .scaleEffect(isOpen ? 0.9 : 1)
                .scaleEffect(show ? 0.92 : 1)
                .ignoresSafeArea()
                .highPriorityGesture(DragGesture(minimumDistance: 25, coordinateSpace: .local)
                            .onEnded { value in
                                if abs(value.translation.height) < abs(value.translation.width) {
                                    if abs(value.translation.width) > 50.0 {
                                        if value.translation.width < 0 {
                                            withAnimation(.spring(response: 0.5, dampingFraction: 0.7)){
                                                isOpen = false

                                            }
                                        } else if value.translation.width > 0 {
                                            withAnimation(.spring(response: 0.5, dampingFraction: 0.7)){
                                                isOpen = true
                                                

                                            }
                                        }
                                  
                                    }
                                }
                            }
                        )
                
                
                Image(systemName: "rectangle.portrait.and.arrow.right")
                    .frame(width: 36, height: 36)
                    .background(.white)
                    .mask(Circle())
                    .shadow(color: Color("Shadow").opacity(0.2), radius: 5, x: 0, y: 5)
                    .onTapGesture {
                        //  print(loginVM.isAuthenticated)
                        print( UserDefaults.standard.string(forKey: "tokenConnexion")!)
                        loginVM.signout()
                        print(loginVM.isAuthenticated)
                        
                        withAnimation(.spring()) {
                            
                            show = true
                            
                            
                            
                            //  print("go to edit profile page")
                            //  show = true
                            //MARK: TAKE ME TO EDIT PROFILE
                            
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                    .padding()
                    .offset(y: 4)
                    .offset(x: isOpen ? 100 : 0)
                   
                
//
//                button.view()
//                    .frame(width: 44, height: 44)
//                    .mask(Circle())
//                    .shadow(color: Color("Shadow").opacity(0.2), radius: 5, x: 0, y: 5)
//                    .frame(maxWidth: .infinity, maxHeight: .infinity , alignment: .topLeading)
//                    .padding()
//                    .offset(x: isOpen ? 216 : 0)
//                    .onTapGesture {
//
//                        button.setInput("isOpen", value: isOpen)
//                        vm.fetchuser()
//                        withAnimation(.spring(response: 0.5, dampingFraction: 0.7)) {
//                            isOpen.toggle()
//
//
//                        }
//
//                    }
                  
                    
                
                TabBar()
                    .offset(y: isOpen ? 300 : 0)
                    .offset(y: show ? 200 : 0)
                    .offset(y: -24)
                    .background(
                        LinearGradient(colors: [Color("Background").opacity(0), Color("Background")], startPoint: .top, endPoint: .bottom)
                            .frame(height: 150)
                            .frame(maxHeight: .infinity, alignment: .bottom)
                            .allowsHitTesting(false)
                    )
                    .ignoresSafeArea()
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
            
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
