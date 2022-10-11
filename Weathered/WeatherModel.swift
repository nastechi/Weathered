//
//  WeatherModel.swift
//  Weathered
//
//  Created by Анастасия on 11.10.2022.
//

import Foundation

struct WeatherModel {
    let name: String
    let weather: [Weather]
    let main: Main
}

struct Weather {
    let id: Int
    let description: String
}

struct Main {
    let temp: Double
    let feels_like: Double
}

struct wind {
    let speed: Double
}
