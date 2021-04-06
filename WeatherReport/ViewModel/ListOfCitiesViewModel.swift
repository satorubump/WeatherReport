//
//  ListOfCitiesViewModel.swift
//  WeatherReport
//
//  Created by Satoru Ishii on 4/4/21.
//

import Foundation
import SwiftUI

class ListOfCitiesViewModel : ObservableObject {
    @Published var citieslist = [City]()
}

struct City {
    let id : Int?
    let name : String?
}
