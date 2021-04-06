//
//  ListOfCitiesView.swift
//  WeatherReport
//
//  Created by Satoru Ishii on 4/4/21.
//

import SwiftUI

struct ListOfCitiesView: View {
    @ObservedObject var viewModel = ListOfCitiesViewModel()
    @State private var showingSheet = false

    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button("Add City") {
                    showingSheet.toggle()
                }
                .sheet(isPresented: $showingSheet) {
                    AddCityView()
                }
                .padding()
            }
            Spacer()
        }
        .navigationBarTitle("My List Of Cities", displayMode: .inline)
    }

}

struct ListOfCitiesView_Previews: PreviewProvider {
    static var previews: some View {
        ListOfCitiesView()
    }
}
