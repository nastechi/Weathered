//
//  ContentView.swift
//  Weathered
//
//  Created by Анастасия on 11.10.2022.
//

import SwiftUI

struct WeatherView: View {
    @StateObject var viewModel = WeatherViewModel()
    @State var searchBar = ""
    
    var body: some View {
        ZStack {
            Color(K.Colors.background)
                .ignoresSafeArea()
            VStack {
                HStack {
                    TextField("Search", text: $searchBar)
                        .onSubmit {
                            viewModel.fetch(city: searchBar)
                            searchBar = ""
                        }
                        .disableAutocorrection(true)
                        .submitLabel(.search)
                    Button {
                        viewModel.fetch(city: searchBar)
                        searchBar = ""
                    } label: {
                        Image(systemName: "magnifyingglass")
                    }
                }
                .foregroundColor(Color(K.Colors.text))
                Text(viewModel.data?.name ?? "")
                    .font(Font.custom(K.Fonts.bold, size: 26))
                    .foregroundColor(Color(K.Colors.text))
                    .padding()
                
                Image(viewModel.getWeatherPicture())
                Spacer()
                Text("\(Int(viewModel.data?.main.temp ?? 0))°C")
                    .font(Font.custom(K.Fonts.light, size: 70))
                    .foregroundColor(Color(K.Colors.text))
                Text(viewModel.data?.weather[0].description ?? "")
                    .font(Font.custom(K.Fonts.light, size: 16))
                    .foregroundColor(Color(K.Colors.accent))
                Spacer()
                
                HStack {
                    BottomInfoView(name: "Wind", data: "\(Int(viewModel.data?.wind.speed ?? 0))m/s")
                    LineView()
                    BottomInfoView(name: "Feels Like", data: "\(Int(viewModel.data?.main.feels_like ?? 0))°C")
                    LineView()
                    BottomInfoView(name: "Sunset", data: viewModel.getSunsetTime())
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
