//
//  clothyApp.swift
//  clothy
//
//  Created by haithem ghattas on 6/11/2022.
//

import SwiftUI

@main
struct clothyApp: App {
    @StateObject private var loginVM = LoginViewModel()
    @State var show = false

    var body: some Scene {
        WindowGroup {
            
        
            ContentView()
            
        }
    }
}
