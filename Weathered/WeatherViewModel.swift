//
//  WeatherViewModel.swift
//  Weathered
//
//  Created by Анастасия on 11.10.2022.
//

import Foundation
import Alamofire

class weatherViewModel: ObservableObject {
    let apiKey = "92c842f410984ff20530d4efddcd0f54"
    @Published var data: WeatherModel?
    
    func fetch(city: String) {
        let url = "https://api.openweathermap.org/data/2.5/weather?units=metric&q=\(city)&appid=\(apiKey)"
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
        if let unixTime = data?.sys.sunset {
            let date = NSDate(timeIntervalSince1970: unixTime)
            var time = "\(date)".split(separator: " ")[1]
            return "\(time.dropLast().dropLast().dropLast())"
        }
        return ""
    }
}
