//
//  clothyApp.swift
//  clothy
//
//  Created by haithem ghattas on 6/11/2022.
//


import SwiftUI
import Firebase
@main
struct clothyApp: App {
    init(){
        FirebaseApp.configure()
    }
    @StateObject var model = Model()

    var body: some Scene {
        WindowGroup {
          ContentView()
               .environmentObject(model)
            
          

        }
    }
}
