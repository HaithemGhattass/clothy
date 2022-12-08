//
//  Closet.swift
//  Clothy
//
//  Created by haithem ghattas on 29/11/2022.
//

import SwiftUI

struct Closet: Identifiable {
    let id = UUID()
    var title : String
    var subtitle : String
    var text : String
    var image : String
    var logo : String
}

var closets = [
    Closet(title: "outwear", subtitle: "--", text: "this is a text", image: "outwear", logo: "Logo 1"),
    Closet(title: "t-shirt", subtitle: "--", text: "this is a text", image: "shirt", logo: "Logo 4"),
    Closet(title: "jean", subtitle: "--", text: "this is a text", image: "jeans", logo: "Logo 3"),
    Closet(title: "hat", subtitle: "--", text: "this is a text", image: "hat", logo: "Logo 2"),
    Closet(title: "shoes", subtitle: "--", text: "this is a text", image: "shoes", logo: "Logo 2")



]
