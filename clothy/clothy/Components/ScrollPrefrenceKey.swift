//
//  PrefrenceKeys.swift
//  Clothy
//
//  Created by haithem ghattas on 29/11/2022.
//

import SwiftUI

struct ScrollPrefrenceKey : PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

