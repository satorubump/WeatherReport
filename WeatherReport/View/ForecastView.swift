//
//  ForecastView.swift
//  WeatherReport
//
//  Created by Satoru Ishii on 3/31/21.
//

import SwiftUI

struct ForecastView: View {
    @ObservedObject var viewModel = ForecastViewModel.shared
    @State var symbol : String?
    var mode = 0
    init(_ m: Int) {
        self.mode = m
    }
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Spacer()
                    NavigationLink(destination: ListOfCitiesView()) {
                        Text("Cities List")
                    }
                    .padding()
                }
                List {
                    if mode == 0 {
                        currentSection
                    }
                    else {
                        hourlySection
                    }
                }
            }
            .navigationBarTitle("⛅️ Near Cites Forecast", displayMode: .inline)
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .onAppear(perform: viewModel.getUpdateData)
    }
}

struct ForecastView_Previews: PreviewProvider {
    static var previews: some View {
        ForecastView(0)
    }
}

private extension ForecastView {
    var currentSection : some View {
        Section {
            ForEach(self.viewModel.cityWeatherRows, id: \.id) { city in
                NavigationLink(destination: CityDetailsView(city)) {
                    HStack {
                        Text(city.name!)
                            .font(.body)
                            .foregroundColor(.black)
                        Text(city.temperature! + "°")
                            .foregroundColor(.gray)
                            .font(.body)
                        Image(systemName: city.symbol!)
                            Text(city.weather!)
                            .font(.caption2)
                            .foregroundColor(.gray)
                    }
                }
            }
        }
    }
    var hourlySection : some View {
        Section {
            ForEach(self.viewModel.cityWeatherRows, id: \.id) { city in
                NavigationLink(destination: HourlyForecastView()) {
                    HStack {
                        Text(city.name!)
                            .font(.body)
                            .foregroundColor(.black)
                        Text(city.temperature! + "°")
                            .foregroundColor(.gray)
                            .font(.body)
                        Image(systemName: city.symbol!)
                        Text(city.weather!)
                            .font(.caption2)
                            .foregroundColor(.gray)
                    }
                }
            }
        }
    }
}
