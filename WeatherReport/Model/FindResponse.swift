//
//  Find.swift
//  WeatherReport
//
//  Created by Satoru Ishii on 4/2/21.
//

import Foundation

struct FindResponse : Codable {
    let message : String
    let cod : String
    let count : Int
    let list : [List]?
    enum CodingKeys : String, CodingKey {
        case message = "message"
        case cod = "cod"
        case count = "count"
        case list = "list"
    }
    struct List : Codable {
        let id : Int
        let name : String
        let coord : [String : Double]?
        let main : Main
        let dt : Int
        let wind : Wind
        let sys : [String : String]?
        let rain : Int?
        let snow : Int?
        let clouds : [String : Int]
        let weather : [Weather]
        enum CodingKeys : String, CodingKey {
            case id = "id"
            case name = "name"
            case coord = "coord"
            case main = "main"
            case dt = "dt"
            case wind = "wind"
            case sys = "sys"
            case rain = "rain"
            case snow = "snow"
            case clouds = "clouds"
            case weather = "weather"
        }
        
        struct Main : Codable {
            let temp : Double
            let feels_like : Double
            let temp_min : Double
            let temp_max : Double
            let pressure : Int
            let humidity : Int
            enum CodingKeys : String, CodingKey {
                case temp = "temp"
                case feels_like = "feels_like"
                case temp_min = "temp_min"
                case temp_max = "temp_max"
                case pressure = "pressure"
                case humidity = "humidity"
            }
        }
        struct Wind : Codable {
            let speed : Double
            let deg : Int
        }
        struct Weather : Codable {
            let id : Int
            let main : String
            let description : String
            let icon : String
            enum CodingKeys : String, CodingKey {
                case id = "id"
                case main = "main"
                case description = "description"
                case icon = "icon"
            }
        }
    }

}
