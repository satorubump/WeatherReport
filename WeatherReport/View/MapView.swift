//
//  MapView.swift
//  WeatherReport
//
//  Created by Satoru Ishii on 4/4/21.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
  private let coordinate: CLLocationCoordinate2D
  
    init(coord: [String : Double]) {
        let coordinate = CLLocationCoordinate2DMake(coord["lat"]!, coord["lon"]!)
        self.coordinate = coordinate
    }
  
  func makeUIView(context: Context) -> MKMapView {
    MKMapView()
  }
  
  func updateUIView(_ view: MKMapView, context: Context) {
    let span = MKCoordinateSpan(latitudeDelta: ConstantsTable.Span, longitudeDelta: ConstantsTable.Span)
    let region = MKCoordinateRegion(center: coordinate, span: span)
    
    let annotation = MKPointAnnotation()
    annotation.coordinate = coordinate
    view.addAnnotation(annotation)
    
    view.setRegion(region, animated: true)
  }
}
