//
//  WeatherViewModel.swift
//  Weathered
//
//  Created by Анастасия on 11.10.2022.
//

import Foundation
import Alamofire
import UIKit
import SwiftUI

class WeatherViewModel: ObservableObject {
    let apiKey = Keys.apiKey
    @Published var data: WeatherModel?
    @Published var locationManager = LocationManager()
    
    var userLatitude: String {
        return "\(locationManager.lastLocation?.coordinate.latitude ?? 0)"
    }
    
    var userLongitude: String {
        return "\(locationManager.lastLocation?.coordinate.longitude ?? 0)"
    }
    
    func fetch(city: String) {
        let cityJoined = city.split(separator: " ").joined(separator: "%20")
        let url = "https://api.openweathermap.org/data/2.5/weather?units=metric&q=\(cityJoined)&appid=\(apiKey)"
        let request = AF.request(url)
        request.responseDecodable(of: WeatherModel.self) { response in
            if let data = response.value {
                self.data = data
            }
        }
    }
    
    func fetch(lat: String, lon: String) {
        let url = "https://api.openweathermap.org/data/2.5/weather?units=metric&lat=\(lat)&lon=\(lon)&appid=\(apiKey)"
        let request = AF.request(url)
        request.responseDecodable(of: WeatherModel.self) { response in
            if let data = response.value {
                self.data = data
            }
        }
    }
    
    func getWeatherPicture() -> String {
        if let id = data?.weather[0].id {
            switch id {
            case 200...232:
                return K.Images.thunder
            case 300...531:
                return K.Images.rain
            case 600...622:
                return K.Images.snow
            case 700...781:
                return K.Images.wind
            case 800:
                return K.Images.sun
            default:
                return K.Images.cloud
            }
        }
        return K.Images.clouds
    }
    
    func getSunsetTime() -> String {
        if var unixTime = data?.sys.sunset, let timezone = data?.timezone {
            unixTime += timezone
            let date = NSDate(timeIntervalSince1970: unixTime)
            let time = "\(date)".split(separator: " ")[1]
            return "\(time.dropLast().dropLast().dropLast())"
        }
        return ""
    }
}
