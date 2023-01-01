//
//  MainView.swift
//  ClothyApp
//
//  Created by haithem ghattas on 18/12/2022.
//

import SwiftUI

struct MainView: View {
    @AppStorage("selectedTab")  var selectedTab: Tab = .home
    @EnvironmentObject var model : Model
    @State private var selectedImage: UIImage?

    var body: some View {
        
          

          
        //    Color("Background 2").ignoresSafeArea()
            
            
            ZStack(alignment: .bottom) {
                
                
               
                    switch selectedTab {
                    case .home:
                        HomeView()
                        

                    case .profile:
                        AccountView()
                        
                    case .add:
                               
                        AddClothesCameraView(sourceType: .photoLibrary, classifier: ImageClassifier())

                     
                        //ImagePickerView(selectedImage: self.$selectedImage, sourceType: .camera)
                      
                        //                        AddClothesCameraView(sourceType: .photoLibrary, classifier: ImageClassifier()).onAppear{
//                            wsManager.socket.cancel()
//
//                        }
                      //  Text("add")
                        
                    case .trade:
                     
                       
                        TradeView()
                    case .chat:
                       // ChatView()
                     //   ShareLocations()
                     //   MessagesSocketView()
//                        ChatRoomsView().onDisappear{
//
//                            wsManager.socket.cancel()
//                        }
                       // MessagesSocketView()
                        ChatListView()
                        
                    }
                
                
                TabBar()
                    .offset(y:model.showsuggestion ? 200 : 0)
                
            }
            .onAppear{
                   
                      //  vm.fetchuser()
              
            }

            .safeAreaInset(edge: .bottom){
                Color.clear.frame(height: 44)
            }
           
        
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
