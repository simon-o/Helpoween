//
//  SearchAddressViewModel.swift
//  HelpCov
//
//  Created by Antoine Simon on 01/06/2020.
//  Copyright © 2020 Antoine Simon. All rights reserved.
//

import Foundation
import GooglePlaces

protocol SearchAddressViewModelProtocol {
    func getLocation(coordinate: GMSPlace)
    
    var fetchLocation: ((GMSPlace) -> Void)? {get set}
    var dismissView: (() -> Void)? {get set}
}

final class SearchAddressViewModel: NSObject {
    var fetchLocation: ((GMSPlace) -> Void)?
    var dismissView: (() -> Void)?
}

extension SearchAddressViewModel: SearchAddressViewModelProtocol {
    func getLocation(coordinate: GMSPlace) {
        if let tmpFetch = fetchLocation, let tmpDismiss = dismissView {
            tmpFetch(coordinate)
            tmpDismiss()
        }
    }
}
