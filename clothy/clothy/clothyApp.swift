//
//  clothyApp.swift
//  clothy
//
//  Created by haithem ghattas on 6/11/2022.
//


import SwiftUI
@main
struct clothyApp: App {
    @StateObject var model = Model()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(model)
        }
    }
}


