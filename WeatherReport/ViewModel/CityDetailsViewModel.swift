//
//  CityWeatherROw.swift
//  WeatherReport
//
//  Created by Satoru Ishii on 4/4/21.
//

import Foundation

struct CityDetailsViewModel {
    let id : Int?
    let name : String?
    let coord : [String : Double]?
    let condition : String?
    let weather : String?
    let temperature : String?
    let maxTemp : String?
    let minTemp : String?
    let wind : String?
    let humidity : String?
    let symbol : String?
}
