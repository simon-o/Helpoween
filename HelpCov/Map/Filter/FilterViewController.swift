//
//  FilterViewController.swift
//  HelpCov
//
//  Created by Antoine Simon on 05/06/2020.
//  Copyright © 2020 Antoine Simon. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController {

    @IBOutlet private weak var qualityLabel: UILabel!
    @IBOutlet private weak var qualitySegmented: UISegmentedControl!
    
    @IBOutlet weak var applyButton: UIButton!
    
    var returnFilters: ((Int) -> Void)?
    private var viewModel: FilterViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel = FilterViewModel()
        
        qualityLabel.text = viewModel?.getQualityLabel()
        applyButton.setTitle(viewModel?.getApplyButtonTitle(), for: .normal)
        if let list = viewModel?.getSegmented() {
            for (index, item) in list.enumerated() {
                qualitySegmented.setTitle(item, forSegmentAt: index)
            }
        }
    }
    
    @IBAction func applyPressed(_ sender: Any) {
        saveFilter()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        saveFilter()
    }
    
    private func saveFilter() {
        let selected = qualitySegmented.selectedSegmentIndex + 1
        returnFilters?(selected)
        self.dismiss(animated: true, completion: nil)
    }
    
}
