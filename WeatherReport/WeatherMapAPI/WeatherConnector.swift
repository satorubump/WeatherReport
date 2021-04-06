//
//  WeatherConnector.swift
//  WeatherReport
//
//  Created by Satoru Ishii on 4/2/21.
//

import Foundation
import CoreLocation
import Combine

enum APIError: Error {
    case network(description: String)
    case decoding(description: String)
}
protocol WeatherConnectorable {
    func findCitiesWeather(forCoordinate Coordinate: CLLocationCoordinate2D) -> AnyPublisher<FindResponse, APIError>
    
}

// The Connector for the Open Weather Service
class WeatherConnector : WeatherConnectorable {
    
    // Get FindResponse data (Around cities weather list) from location
    func findCitiesWeather(forCoordinate location: CLLocationCoordinate2D) -> AnyPublisher<FindResponse, APIError> {
        let urlComponents = self.makeFindRequestUrl(forCoordinate: location)
        return publishConnector(urlComponents: urlComponents)
    }
    
    // Create the find request url from location coordinates
    private func makeFindRequestUrl(forCoordinate location: CLLocationCoordinate2D) -> URLComponents {
        var urlComp = URLComponents()
        urlComp.scheme = ConstantsTable.Scheme
        urlComp.host = ConstantsTable.Host
        urlComp.path = ConstantsTable.Path + ConstantsTable.FindReq
        
        urlComp.queryItems = [
            URLQueryItem(name: "lat", value: String(location.latitude)),
            URLQueryItem(name: "lon", value: String(location.longitude)),
            URLQueryItem(name: "cnt", value: ConstantsTable.Cnt),
            URLQueryItem(name: "mode", value: ConstantsTable.Mode),
            URLQueryItem(name: "units", value: ConstantsTable.Units),
            URLQueryItem(name: "APPID", value: ConstantsTable.APIKey)
        ]
        return urlComp
    }
    
    // Connect Service API, Downloading and Publish the data
    private func publishConnector(urlComponents components: URLComponents) -> AnyPublisher<FindResponse, APIError> {
        guard let url = components.url else {
            let error = APIError.network(description: "Can't create URL")
            return Fail(error: error).eraseToAnyPublisher()
        }
        return URLSession.shared.dataTaskPublisher(for: URLRequest(url: url))
          .mapError { error in
            .network(description: error.localizedDescription)
          }
          .flatMap(maxPublishers: .max(1)) { pair in
                self.decode(pair.data)
          }
          .eraseToAnyPublisher()
    }
    
    // Decode json data to FindResponse struct data
    private func decode(_ data: Data) -> AnyPublisher<FindResponse, APIError> {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970

        return Just(data)
          .decode(type: FindResponse.self, decoder: decoder)
            // for debug .print()
          .mapError { error in
            .decoding(description: error.localizedDescription)
          }
          .eraseToAnyPublisher()
    }
}
