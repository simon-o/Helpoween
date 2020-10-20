//
//  ViewController.swift
//  HelpCov
//
//  Created by Antoine Simon on 15/05/2020.
//  Copyright © 2020 Antoine Simon. All rights reserved.
//

import UIKit
import MapKit

final class ViewController: UIViewController {
    
    @IBOutlet private weak var map: MKMapView!
    @IBOutlet private weak var filterButton: UIButton!
    @IBOutlet private weak var addButton: UIButton!
    
    private var viewModel: MapViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUp()
        startMap()
    }

    private func setUp() {
        viewModel = MapViewModel(service: MapService())
        
        viewModel?.updateLocalisation = updateLocalisation
        viewModel?.addMarker = addMarker
        viewModel?.displayInfos = displayInfos
        viewModel?.removeMarkers = removeMarkers
        
        setUpButton(button: addButton, image: UIImage(named: "plus")!)
        
        map.showsUserLocation = true
        map.delegate = self
    }
    
    private func filterPressed() {
        let controller = FilterViewController()
        controller.returnFilters = applyFilters
        self.present(controller, animated: true)
    }
    
    private func applyFilters(filters: Int) {
        viewModel?.apply(filters: filters)
    }
    
    private func setUpButton(button: UIButton, image: UIImage) {
        button.tintColor = .white
        button.layer.masksToBounds = true
        button.layer.cornerRadius = button.frame.width/2
        button.setImage(image, for: .normal)
        button.setTitle(nil, for: .normal)
    }
    
    private func addPressed() {
        self.present(AddReviewViewController(), animated: true, completion: nil)
    }
    
    private func displayInfos(view: ReviewTableViewController) {
        self.present(view, animated: true)
    }
    
    private func startMap() {
        viewModel?.getLocation()
        viewModel?.loadMarker()
    }
    
    private func updateLocalisation(local: CLLocationCoordinate2D) {
        map.setRegion(MKCoordinateRegion.init(center: local, span: MKCoordinateSpan.init(latitudeDelta: 0.5, longitudeDelta: 0.5)), animated: true)
    }
    
    private func addMarker(markers: [MKPointAnnotation]) {
        for mark in markers {
            map.addAnnotation(mark)
        }
    }
    
    private func removeMarkers(markers: [MKPointAnnotation]) {
        map.removeAnnotations(markers)
    }
    
    @IBAction func filterButtonPressed(_ sender: Any) {
        filterPressed()
    }
    @IBAction func addButtonPressed(_ sender: Any) {
        addPressed()
    }
}

extension ViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let annotation = view.annotation as? MKPointAnnotation else { return }
        viewModel?.searchMarker(mark: annotation)
        map.deselectAnnotation(annotation, animated: false)
    }
}
