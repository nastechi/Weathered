//
//  WeatherViewModel.swift
//  Weathered
//
//  Created by Анастасия on 11.10.2022.
//

import Foundation

class weatherViewModel: ObservableObject {
    let apiKey = "92c842f410984ff20530d4efddcd0f54"
    let apicall = "https://api.openweathermap.org/data/2.5/weather?units=metric&appid=92c842f410984ff20530d4efddcd0f54&q=paris"
}
