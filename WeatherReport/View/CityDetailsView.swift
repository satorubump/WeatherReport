//
//  CityDetails.swift
//  WeatherReport
//
//  Created by Satoru Ishii on 4/4/21.
//

import SwiftUI

struct CityDetailsView: View {
    var city : CityDetailsViewModel?
    var conditionSymbol : String?
    
    init?(_ ct: CityDetailsViewModel?) {
        if ct == nil {
            return
        }
        self.city = ct
        if let symbol = SymbolsMap.ConditionSymbolMap[ct!.condition!] {
            self.conditionSymbol = symbol
        }
        else {
            self.conditionSymbol = "⛅️"
        }
    }
    var body: some View {
        VStack {
            HStack {
                Image(systemName: self.conditionSymbol!)
                    .resizable()
                    .frame(width: 70, height: 47)
                    .aspectRatio(contentMode: .fit)
                Text(city!.temperature! + "°")
                    .font(.system(size: 45))
                    .foregroundColor(Color.gray)
                Text(city!.name!)
                    .font(.system(size: 30))
                    .foregroundColor(Color.gray)
            }
            .padding()

            MapView(coord: city!.coord!)
              .cornerRadius(25)
              .frame(height: 300)
              .disabled(true)

            List {
                HStack {
                    Text("📈 Max temperature:")
                        Text("\(city!.maxTemp!)°")
                }
                .foregroundColor(.gray)

                HStack {
                    Text("📉 Min temperature:")
                    Text("\(city!.minTemp!)°")
                }
                .foregroundColor(.gray)

                HStack {
                    Image(systemName: "wind")
                    Text("Wind Speed:")
                    Text(city!.wind!)
                }
                .foregroundColor(.gray)

                HStack {
                    Text("💧 Humidity:")
                    Text(city!.humidity!)
                }
                .foregroundColor(.gray)
            }
        }
        .navigationBarTitle("⛅️ Current City Weather", displayMode: .inline)
    }
}

struct CityDetails_Previews: PreviewProvider {
    static var previews: some View {
        CityDetailsView(nil)
    }
}
