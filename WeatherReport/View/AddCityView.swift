//
//  AddCityView.swift
//  WeatherReport
//
//  Created by Satoru Ishii on 4/5/21.
//

import SwiftUI

struct AddCityView: View {
    @State private var searchText : String = ""

    var body: some View {
        VStack {
            SearchBarView(text: $searchText)
            Spacer()
        }
    }
}

struct AddCityView_Previews: PreviewProvider {
    static var previews: some View {
        AddCityView()
    }
}
