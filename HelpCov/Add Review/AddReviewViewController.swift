//
//  AddReviewViewController.swift
//  HelpCov
//
//  Created by Antoine Simon on 29/05/2020.
//  Copyright © 2020 Antoine Simon. All rights reserved.
//

import UIKit
import MapKit
import GooglePlaces

final class AddReviewViewController: UIViewController {
    
    private var viewModel: AddReviewViewModelProtocol?
    private var searchVC: SearchAddressViewController?
    
    @IBOutlet private weak var searchButton: UIButton!
    
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var nameView: UIView!
    
    @IBOutlet private weak var maskCustomerLabel: UILabel!
    @IBOutlet private weak var maskCustomerSegmented: UISegmentedControl!
    
    @IBOutlet private weak var maskEmployeLabel: UILabel!
    @IBOutlet private weak var maskEmployeSegmented: UISegmentedControl!
    
    @IBOutlet private weak var distancingLabel: UILabel!
    @IBOutlet private weak var distancingSegmented: UISegmentedControl!
    
    @IBOutlet private weak var saveButton: UIButton!
    
    @IBOutlet private var ArraySegmented: [UISegmentedControl]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchVC = SearchAddressViewController()
        
        setUp()
        setUpUI()
        setUpSegmented()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewModel?.donePressed()
    }
    
    private func setUpUI() {
        saveButton.backgroundColor = UIColor.init(named: "ButtonColor")
        searchButton.backgroundColor = UIColor.init(named: "ButtonColor")
    }
    
    private func setUp() {
        viewModel = AddReviewViewModel(service: MapService())
        searchVC?.fetchLocation = viewModel?.fetchLocation
        viewModel?.updateName = updateName
        
        nameLabel.text = nil
        nameView.isHidden = true
        maskCustomerLabel.text = viewModel?.getMaskCustomer()
        maskEmployeLabel.text = viewModel?.getMaskEmploye()
        distancingLabel.text = viewModel?.getDistance()
        
        searchButton.setTitle(viewModel?.getSearchButton(), for: .normal)
        saveButton.setTitle(viewModel?.getSaveButton(), for: .normal)
        
        viewModel?.getMaskCustomerValue = getMaskCustomerValue
        viewModel?.getMaskEmployeValue = getMaskEmployeValue
        viewModel?.getDistancingValue = getDistancingValue

        viewModel?.popToPreviousView = popToPreviousView
    }
    
    private func popToPreviousView() {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func getMaskCustomerValue() -> Bool {
        return maskCustomerSegmented.isTrue()
    }
    private func getMaskEmployeValue() -> Bool {
        return maskEmployeSegmented.isTrue()
    }
    private func getDistancingValue() -> Bool {
        return distancingSegmented.isTrue()
    }
    
    private func updateName(name: String) {
        nameLabel.text = name
        nameView.isHidden = false
    }
    
    private func setUpSegmented() {
        for segmented in ArraySegmented {
            segmented.setTitle(viewModel?.getYesLabel(), forSegmentAt: 0)
            segmented.setTitle(viewModel?.getNoLabel(), forSegmentAt: 1)
        }
    }

    @IBAction func searchAddressPressed(_ sender: Any) {
        if let tmpSearchVC = searchVC {
            self.present(tmpSearchVC, animated: true, completion: nil)
        }
    }
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
