//
//  ReviewViewModel.swift
//  HelpCov
//
//  Created by Antoine Simon on 04/06/2020.
//  Copyright © 2020 Antoine Simon. All rights reserved.
//

import UIKit

protocol ReviewViewModelProtocol {
    func configure(cell: ReviewTableViewCell, review: MapPoint)
    func configure(header: ReviewHeaderTableViewCell, infos: ListPoint)
    
    var closePressed: (() -> Void)? {get set}
}

final class ReviewViewModel: NSObject {
    var closePressed: (() -> Void)?
    
    private func applyMain(text: String, second: String, bool: Bool?) -> NSAttributedString {
        let formattext = text + ":\n"
        let myAttributeMain = [NSAttributedString.Key.foregroundColor: UIColor.init(red: 0.023, green: 0.094, blue: 0.537, alpha: 1),
                               NSAttributedString.Key.font: UIFont(name: "Helvetica", size: 15.0)!]
        let partOne = NSAttributedString(string: formattext, attributes: myAttributeMain)
        
        var myAttributeSecond = [NSAttributedString.Key.foregroundColor: bool == true ? UIColor.init(red: 0.305, green: 0.660, blue: 0, alpha: 1) : UIColor.init(red: 0.660, green: 0.089, blue: 0, alpha: 1),
                                 NSAttributedString.Key.font: UIFont(name: "Helvetica", size: 15.0)!]
        if bool == nil { myAttributeSecond = [NSAttributedString.Key.foregroundColor: UIColor.init(red: 0.757, green: 0.728, blue: 0.041, alpha: 1)] }
        let partTwo = NSAttributedString(string: second, attributes: myAttributeSecond)
        
        let combination = NSMutableAttributedString()
        combination.append(partOne)
        combination.append(partTwo)
        
        return combination
    }
    
    private func closedPressed() {
        closePressed?()
    }
}

extension ReviewViewModel: ReviewViewModelProtocol {
    func configure(header: ReviewHeaderTableViewCell, infos: ListPoint) {
        header.setTitle(infos.array.first?.title ?? "")
        header.closedPressed = closedPressed
    }
    
    func configure(cell: ReviewTableViewCell, review: MapPoint) {
        
        cell.setMaskCustomer(applyMain(text: "have_candy".localizedString, second: review.maskCustomer.convertString(), bool: review.maskCustomer))
        cell.setMaskEmploye(applyMain(text: "vegan_candy".localizedString, second: review.maskEmploye.convertString(), bool: review.maskEmploye))
        cell.setDistancing(applyMain(text: "halal_candy".localizedString, second: review.distancing.convertString(), bool: review.distancing))
    }
}
