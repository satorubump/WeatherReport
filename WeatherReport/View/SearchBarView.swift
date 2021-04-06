//
//  SearchBarView.swift
//  WeatherReport
//
//  Created by Satoru Ishii on 4/5/21.
//

import Foundation
import SwiftUI
import GooglePlaces

struct SearchBarView : UIViewRepresentable {
    

    @Binding var text: String
    var placeholder: String = ConstantsTable.Placeholder

    
    func updateUIView(_ uiView: UISearchBar, context: Context) {
    }
    
    func makeUIView(context: Context) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = context.coordinator
        searchBar.placeholder = placeholder
        searchBar.searchBarStyle = .minimal
        searchBar.autocapitalizationType = .none
        return searchBar
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(text: $text)
    }
    //
    class Coordinator: NSObject, UISearchBarDelegate, GMSAutocompleteViewControllerDelegate {
        
        @Binding var text: String

        func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
            print("didAutocompleteWith")
        }
        
        func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
            
        }
        
        func wasCancelled(_ viewController: GMSAutocompleteViewController) {
            
        }

        init(text: Binding<String>) {
            _text = text
        }

        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            text = searchText
            searchBar.showsCancelButton = true
            print("searchBar textDidChange \(searchText)")
            let autocompleteController = GMSAutocompleteViewController()
             autocompleteController.delegate = self
        }

        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            searchBar.resignFirstResponder()

            // cancel ボタンを押すまで、cancelを有効に
            if let cancelButton = searchBar.value(forKey: "cancelButton") as? UIButton {
                cancelButton.isEnabled = true
            }
            searchBar.endEditing(true)
        }

        func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
            text = ""
            searchBar.resignFirstResponder()
            searchBar.showsCancelButton = false
            searchBar.endEditing(true)
        }
    }
}
