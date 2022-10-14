//
//  WeatherModel.swift
//  Weathered
//
//  Created by Анастасия on 11.10.2022.
//

import Foundation

struct WeatherModel: Decodable {
    let name: String
    let weather: [Weather]
    let main: Main
    let wind: Wind
    let sys: Sys
    let timezone: Double
}

struct Weather: Decodable {
    let id: Int
    let description: String
}

struct Main: Decodable {
    let temp: Double
    let feels_like: Double
}

struct Wind: Decodable {
    let speed: Double
}

struct Sys: Decodable {
    let sunset: Double
}
