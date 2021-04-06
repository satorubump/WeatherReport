//
//  ContentView.swift
//  WeatherReport
//
//  Created by Satoru Ishii on 3/31/21.
//

import SwiftUI

struct AppTabView: View {
    var body: some View {
        TabView {
            ForecastView(0)
            .tabItem {
                Image(systemName: "sun.min.fill")
                Text("Current")
            }
            ForecastView(1)
            .tabItem {
                Image(systemName: "stopwatch")
                Text("Hourly")
            }
        }
    }
}

struct AppTabView_Previews: PreviewProvider {
    static var previews: some View {
        AppTabView()
    }
}
