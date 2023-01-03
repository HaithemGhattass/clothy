//
//  Weather.swift
//  ClothyApp
//
//  Created by haithem ghattas on 31/12/2022.
//

import Foundation
struct Weather: Identifiable {
    let id = UUID()
    
    let temperature: Int
    let weatherCode: WeatherCode
}
