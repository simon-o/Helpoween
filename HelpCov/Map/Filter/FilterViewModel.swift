//
//  FilterViewModel.swift
//  HelpCov
//
//  Created by Antoine Simon on 05/06/2020.
//  Copyright © 2020 Antoine Simon. All rights reserved.
//

import Foundation

protocol FilterViewModelProtocol {
    func getQualityLabel() -> String
    func getSegmented() -> [String]
    func getApplyButtonTitle() -> String
}

final class FilterViewModel: NSObject {
    
}

extension FilterViewModel: FilterViewModelProtocol {
    func getQualityLabel() -> String {
        return "quality_label".localizedString
    }
    
    func getSegmented() -> [String] {
        return ["1","2","3","4","5"]
    }
    
    func getApplyButtonTitle() -> String {
        return "apply_button".localizedString
    }
}
