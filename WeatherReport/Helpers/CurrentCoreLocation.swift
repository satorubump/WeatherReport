//
//  CurrentLocation.swift
//  WeatherReport
//
//  Created by Satoru Ishii on 4/3/21.
//

import Foundation
import CoreLocation
import SwiftUI

class CurrentCoreLocation : NSObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    var lastLocation : CLLocationCoordinate2D?
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func getCurrent() -> CLLocationCoordinate2D? {
        return lastLocation
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        self.lastLocation = location.coordinate
    }
}
