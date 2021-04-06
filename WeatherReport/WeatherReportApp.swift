//
//  WeatherReportApp.swift
//  WeatherReport
//
//  Created by Satoru Ishii on 3/31/21.
//

import SwiftUI
import GooglePlaces

@main
struct WeatherReportApp: App {
    init() {
        GMSPlacesClient.provideAPIKey(ConstantsTable.APIKey)
    }
    var body: some Scene {
        WindowGroup {
            AppTabView()
        }
    }
}
