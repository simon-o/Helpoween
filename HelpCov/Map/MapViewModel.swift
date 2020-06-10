//
//  MapViewModel.swift
//  HelpCov
//
//  Created by Antoine Simon on 15/05/2020.
//  Copyright © 2020 Antoine Simon. All rights reserved.
//

import UIKit
import MapKit

protocol MapViewModelProtocol {
    func getLocation()
    func loadMarker()
    func searchMarker(mark: MKPointAnnotation)
    func apply(filters: Int)
    
    var updateLocalisation: ((CLLocationCoordinate2D) -> Void)? {get set}
    var addMarker: (([MKPointAnnotation]) -> Void)? {get set}
    var displayInfos: ((ReviewTableViewController) -> Void)? {get set}
    var removeMarkers: (([MKPointAnnotation]) -> Void)? {get set}
}

final class MapViewModel: NSObject {
    var updateLocalisation: ((CLLocationCoordinate2D) -> Void)?
    var addMarker: (([MKPointAnnotation]) -> Void)?
    var displayInfos: ((ReviewTableViewController) -> Void)?
    var removeMarkers: (([MKPointAnnotation]) -> Void)?
    
    private var isRegionSet = false
    
    private let service: MapServiceProtocol
    private var list: [ListPoint]? {
        didSet {
            if let list = list {
                self.listMark = self.createAnnotation(list: list)
            }
        }
    }
    private let locationManager = CLLocationManager()
    private var listMark: [MKPointAnnotation]? {
        didSet {
            if let tmp = addMarker {
                tmp(listMark ?? [])
            }
        }
    }
    
    init(service: MapServiceProtocol) {
        self.service = service
    }
    
    private func createAnnotation(list: [ListPoint]) -> [MKPointAnnotation] {
        var returnArray = [MKPointAnnotation]()
        
        for point in list {
            let annotation = MKPointAnnotation()
            annotation.coordinate = point.array.first?.locationCoordinate() ?? CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0)
            annotation.title = point.array.first?.title
            returnArray.append(annotation)
        }
        return returnArray
    }
}

extension MapViewModel: MapViewModelProtocol {
    func apply(filters: Int) {
        guard let listMark = listMark else { return }
        removeMarkers?(listMark)
        if let list = list {
            self.listMark = createAnnotation(list: list.filter { $0.rating >= Double(filters) })
        }
    }
    
    func searchMarker(mark: MKPointAnnotation) {
        if let list = list {
            for tmp in list {
                if mark.title == tmp.array.first?.title {
                    self.displayInfos?(ReviewTableViewController.init(list: tmp, viewModel: ReviewViewModel()))
                }
            }
        }
    }
    
    func getLocation() {
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()

        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    
    func loadMarker() {
        service.getValue { (result) in
            switch result {
            case .success(let list):
                self.list = list
            case .failure(let error):
                fatalError(error.localizedDescription)
            }
        }
    }
}

extension MapViewModel: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        if isRegionSet == false {
            updateLocalisation?(locValue)
            isRegionSet = true
        }
    }
    
    
}

private extension MKMapView {
    
    func centerToLocation(
        _ location: CLLocation,
        regionRadius: CLLocationDistance = 1000
    ) {
        let coordinateRegion = MKCoordinateRegion(
            center: location.coordinate,
            latitudinalMeters: regionRadius,
            longitudinalMeters: regionRadius)
        setRegion(coordinateRegion, animated: true)
    }
}
