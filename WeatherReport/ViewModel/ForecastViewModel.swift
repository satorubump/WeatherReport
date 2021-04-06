//
//  ForecastViewModel.swift
//  WeatherReport
//
//  Created by Satoru Ishii on 4/2/21.
//

import Foundation
import CoreLocation
import Combine


final class ForecastViewModel : ObservableObject {
    static let shared = ForecastViewModel()
    @Published var cityWeatherRows = [CityDetailsViewModel]()
    @Published var currentCoordinate : CLLocationCoordinate2D?
    @Published var errorMessage : String?
    
    var findResponse : FindResponse? {
        didSet {
            self.getCityWeatherRow()
        }
    }
    let weatherConnector = WeatherConnector()
    let coreLocation = CurrentCoreLocation()
    private var disposables = Set<AnyCancellable>()

    private init() {
    }

    func getUpdateData() {
        DispatchQueue.global().asyncAfter(deadline: .now() + 1.0) {
            self.getCitiesWeather()
        }
    }
    private func getCitiesWeather() {
        guard let coordinate = self.coreLocation.getCurrent() else {
            self.errorMessage = "Can't get current location!"
            return
        }

        weatherConnector.findCitiesWeather(forCoordinate: coordinate)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] value in
                guard let self = self else { return }
                switch value {
                case .failure:
                  self.findResponse = nil
                case .finished:
                  break
                }
              },
              receiveValue: { [weak self] findResponse in
                self!.findResponse = findResponse
              })
            .store(in: &disposables)
    }
    
    func getCityWeatherRow() -> Void {
        guard let findRes = self.findResponse else {
            return
        }
        guard let cities = findRes.list else {
            return
        }

        self.cityWeatherRows.removeAll()
        cities.forEach() { city in
            let id = city.id
            let name = city.name
            let coord = city.coord
            let condition = String(city.weather[0].icon.prefix(2))
            let weather = String(city.weather[0].description)
            let temperature = String(format: "%.0f", city.main.temp)
            let maxtemp = String(format: "%.0f", city.main.temp_max)
            let mintemp = String(format: "%.0f", city.main.temp_min)
            let wind = String(city.wind.speed)
            let humidity = String(city.main.humidity)
            var symbol : String?
            if let symb = SymbolsMap.ConditionSymbolMap[condition] {
                symbol = symb
            }
            else {
                symbol = ""
            }
            let cityWeatherRow = CityDetailsViewModel(id: id, name: name, coord : coord, condition: condition, weather: weather, temperature: temperature, maxTemp: maxtemp, minTemp: mintemp, wind: wind, humidity: humidity, symbol: symbol)
            self.cityWeatherRows.append(cityWeatherRow)
        }
    }
}

struct CityCell {
    let weather : String
    let temperature : Double
}
