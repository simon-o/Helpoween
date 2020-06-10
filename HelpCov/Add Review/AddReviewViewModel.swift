//
//  AddReviewViewModel.swift
//  HelpCov
//
//  Created by Antoine Simon on 29/05/2020.
//  Copyright © 2020 Antoine Simon. All rights reserved.
//

import UIKit
import MapKit
import GooglePlaces

protocol AddReviewViewModelProtocol {
    func donePressed()
    
    func fetchLocation(coordinate: GMSPlace)
    func getMaskCustomer() -> String
    func getMaskEmploye() -> String
    func getDistance() -> String
    
    func getSearchButton() -> String
    func getNavTitle() -> String
    func getSaveButton() -> String
    
    var updateName: ((String) -> Void)? {get set}
    
    var getMaskCustomerValue: (() -> Bool)? {get set}
    var getMaskEmployeValue: (() -> Bool)? {get set}
    var getDistancingValue: (() -> Bool)? {get set}
    
    var popToPreviousView: (() -> Void)? {get set}
    
    func getYesLabel() -> String
    func getNoLabel() -> String
    
}

final class AddReviewViewModel: NSObject {

    let service: MapServiceProtocol
    var updateName: ((String) -> Void)?
    
    var getMaskCustomerValue: (() -> Bool)?
    var getMaskEmployeValue: (() -> Bool)?
    var getDistancingValue: (() -> Bool)?
    
    var popToPreviousView: (() -> Void)?
    
    private var place: GMSPlace? {
        didSet {
            updateInformations()
        }
    }
    
    init(service: MapServiceProtocol) {
        self.service = service
    }
    
    private func updateInformations() {
        if let name = place?.name {
            updateName?("\("name_label".localizedString): \(String(describing: name))")
        }
    }
}

extension AddReviewViewModel: AddReviewViewModelProtocol {
    func fetchLocation(coordinate: GMSPlace) {
        place = coordinate
    }
    
    func getSaveButton() -> String {
        return "save_label".localizedString
    }
    
    func getMaskCustomer() -> String {
        return "have_candy".localizedString
    }
    
    func getMaskEmploye() -> String {
        return "vegan_candy".localizedString
    }
    
    func getDistance() -> String {
        return "halal_candy".localizedString
    }
    
    func getSearchButton() -> String {
        return "search_button_title".localizedString
    }
    
    func getYesLabel() -> String {
        return "yes_label".localizedString
    }
    
    func getNoLabel() -> String {
        return "no_label".localizedString
    }
    
    func getNavTitle() -> String {
        return "save_label".localizedString
    }
    
    func donePressed() {
        if let place = place {
            service.addValue(name: place.name ?? "",
                             location: place.coordinate ,
                             address: place.formattedAddress ?? "",
                             maskCutomer: getMaskCustomerValue?() ?? false,
                             maskEmploye: getMaskEmployeValue?() ?? false,
                             distancing: getDistancingValue?() ?? false) { (result) in
                                switch result {
                                case .success:
                                    self.popToPreviousView?()
                                case .failure(let error): break
                                }
            }
        }
    }
}
