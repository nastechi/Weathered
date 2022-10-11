//
//  ContentView.swift
//  Weathered
//
//  Created by Анастасия on 11.10.2022.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = weatherViewModel()
    @State var city = "Paris"
    @State var searchBar = ""
    @State var wind = "4m/s"
    var body: some View {
        ZStack {
            Color(K.Colors.background)
                .ignoresSafeArea()
            VStack {
                HStack {
                    TextField("Search", text: $searchBar)
                    Button {
                        city = searchBar
                        searchBar = ""
                    } label: {
                        Image(systemName: "magnifyingglass")
                    }
                }
                .foregroundColor(Color(K.Colors.text))
                Text(city)
                    .font(Font.custom(K.Fonts.bold, size: 26))
                    .foregroundColor(Color(K.Colors.text))
                    .padding()
                Image(K.Images.cloud)
                    .padding(.vertical, 60)
                Text("22°C")
                    .font(Font.custom(K.Fonts.light, size: 70))
                    .foregroundColor(Color(K.Colors.text))
                Text("Cloudy")
                    .font(Font.custom(K.Fonts.light, size: 16))
                    .foregroundColor(Color(K.Colors.accent))
                Spacer()
                
                HStack {
                    BottomInfoView(name: "Wind", data: wind)
                    LineView()
                    BottomInfoView(name: "Feels Like", data: wind)
                    LineView()
                    BottomInfoView(name: "Sunset", data: wind)
                }
            }
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
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
