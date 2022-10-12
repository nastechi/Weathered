//
//  ContentView.swift
//  Weathered
//
//  Created by Анастасия on 11.10.2022.
//

import SwiftUI

struct WeatherView: View {
    @StateObject var viewModel = weatherViewModel()
    @State var searchBar = ""
    
    var body: some View {
        ZStack {
            Color(K.Colors.background)
                .ignoresSafeArea()
            VStack {
                HStack {
                    TextField("Search", text: $searchBar)
                    Button {
                        viewModel.fetch(city: searchBar)
                        searchBar = ""
                    } label: {
                        Image(systemName: "magnifyingglass")
                    }
                }
                .foregroundColor(Color(K.Colors.text))
                if let cityName = viewModel.data?.name, let weather = viewModel.data?.main.temp, let description = viewModel.data?.weather[0].description, let wind = viewModel.data?.wind.speed, let feelsLike = viewModel.data?.main.feels_like {
                    Text(cityName)
                        .font(Font.custom(K.Fonts.bold, size: 26))
                        .foregroundColor(Color(K.Colors.text))
                        .padding()
                    
                    Image(viewModel.getWeatherPicture())
                    Spacer()
                    Text("\(Int(weather))°C")
                        .font(Font.custom(K.Fonts.light, size: 70))
                        .foregroundColor(Color(K.Colors.text))
                    Text(description)
                        .font(Font.custom(K.Fonts.light, size: 16))
                        .foregroundColor(Color(K.Colors.accent))
                    Spacer()
                    
                    HStack {
                        BottomInfoView(name: "Wind", data: "\(Int(wind))m/s")
                        LineView()
                        BottomInfoView(name: "Feels Like", data: "\(Int(feelsLike))")
                        LineView()
                        BottomInfoView(name: "Sunset", data: viewModel.getSunsetTime())
                    }
                }
            }
            .padding()
        }
        .onAppear {
            viewModel.fetch(lat: viewModel.userLatitude, lon: viewModel.userLongitude)
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView()
    }
}

struct BottomInfoView: View {
    let name: String
    let data: String
    
    var body: some View {
        VStack {
            Text(data)
                .font(Font.custom(K.Fonts.light, size: 26))
                .foregroundColor(Color(K.Colors.text))
            Text(name)
                .font(Font.custom(K.Fonts.light, size: 14))
                .foregroundColor(Color(K.Colors.accent))
        }
        .padding()
    }
}

struct LineView: View {
    var body: some View {
        Rectangle()
            .fill(Color(K.Colors.accent))
            .frame(width: 1, height: 40)
    }
}
