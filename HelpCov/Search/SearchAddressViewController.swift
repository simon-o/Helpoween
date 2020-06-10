//
//  SearchAddressViewController.swift
//  HelpCov
//
//  Created by Antoine Simon on 01/06/2020.
//  Copyright © 2020 Antoine Simon. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

class SearchAddressViewController: UIViewController {

    var resultsViewController: GMSAutocompleteResultsViewController?
    var searchController: UISearchController?
    private var viewModel: SearchAddressViewModelProtocol?
    
    var fetchLocation: ((GMSPlace) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel = SearchAddressViewModel()
        viewModel?.dismissView = dismiss
        viewModel?.fetchLocation = returnLocation
        setupSearchController()
    }

    func setupSearchController() {
        resultsViewController = GMSAutocompleteResultsViewController()
        searchController = UISearchController(searchResultsController: resultsViewController)
        searchController?.searchResultsUpdater = resultsViewController

        let searchBar = searchController!.searchBar
        searchBar.sizeToFit()
        searchBar.placeholder = "Search for places"
        view.addSubview(searchBar)
        definesPresentationContext = true
        searchController?.hidesNavigationBarDuringPresentation = false
        resultsViewController?.delegate = self
    }
    
    private func returnLocation(coordinate: GMSPlace) {
        if let tmpFetch = fetchLocation {
            tmpFetch(coordinate)
        }
    }
    
    private func dismiss() {
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension SearchAddressViewController: GMSAutocompleteResultsViewControllerDelegate {
    func resultsController(_ resultsController: GMSAutocompleteResultsViewController,
                           didAutocompleteWith place: GMSPlace) {
        searchController?.isActive = false
        viewModel?.getLocation(coordinate: place)
    }

    func resultsController(_ resultsController: GMSAutocompleteResultsViewController,
                           didFailAutocompleteWithError error: Error){
        print("Error: ", error.localizedDescription)
    }
}
