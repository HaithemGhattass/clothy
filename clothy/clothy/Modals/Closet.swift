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
    var text : String
    var image : String
    var logo : String
}

var closets = [
    Closet(title: "outwear", text: "this is a text", image: "outwear", logo: "Logo 1"),
    Closet(title: "t-shirt", text: "this is a text", image: "shirt", logo: "Logo 4"),
    Closet(title: "jean", text: "this is a text", image: "jeans", logo: "Logo 3"),
    Closet(title: "hat", text: "this is a text", image: "hat", logo: "Logo 2"),
    Closet(title: "shoes", text: "this is a text", image: "shoes", logo: "Logo 2")



]
