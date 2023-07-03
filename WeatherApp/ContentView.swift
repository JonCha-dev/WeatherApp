//
//  ContentView.swift
//  WeatherApp
//
//  Created by Jon Chang on 6/25/23.
//

import SwiftUI

struct ContentView: View {
    @State var searchText = ""
    
    @StateObject var viewModel = WeatherViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(colors: [.yellow, .orange, Color(red: 1, green: 0.416, blue: 0)], startPoint: .topLeading, endPoint: .bottomTrailing)
                    .ignoresSafeArea(.all)
                
                VStack {
                    searchField
                        .padding([.bottom], 15)
                    listView()
                    Spacer()
                }
                .navigationTitle("Weather")
                .onChange(of: searchText) { newValue in
                    viewModel.getWeather(newValue)
                }
            }
        }
    }
    
    private func listView() -> some View {
        WeatherCell(weather: viewModel.data)
    }
    
    private var searchField: some View {
        HStack(spacing: 15) {
            Image(systemName: "magnifyingglass")
            TextField("Search for a city/state", text: $searchText)
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(15)
        .padding(.horizontal, 16)

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
