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
    
    private func applyMain(text: String, second: String, bool: Bool) -> NSAttributedString {
        let formattext = text + ":\n"
        let myAttributeMain = [NSAttributedString.Key.foregroundColor: UIColor.init(named: "SecondTextColor"),
                               NSAttributedString.Key.font: UIFont(name: "Helvetica", size: 19.0)!]
       
        
        let myAttributeSecond = [NSAttributedString.Key.foregroundColor: bool == true ?
                                    UIColor.init(named: "TrueColor") :
                                    UIColor.init(named: "FalseColor"),
                                 NSAttributedString.Key.font: UIFont(name: "Helvetica", size: 18.0)!]
//        if bool == nil { myAttributeSecond = [NSAttributedString.Key.foregroundColor: UIColor.init(red: 0.757, green: 0.728, blue: 0.041, alpha: 1)] }
        
        let partOne = NSAttributedString(string: formattext, attributes: myAttributeMain as [NSAttributedString.Key : Any])
        let partTwo = NSAttributedString(string: second, attributes: myAttributeSecond as [NSAttributedString.Key : Any])
        
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
        header.setShadow()
        header.setTitle(infos.array.first?.title ?? "")
        header.closedPressed = closedPressed
    }
    
    func configure(cell: ReviewTableViewCell, review: MapPoint) {
        
        cell.setHaveCandy(applyMain(text: "have_candy".localizedString, second: review.maskCustomer.convertString(), bool: review.maskCustomer))
        cell.setVeganCandy(applyMain(text: "vegan_candy".localizedString, second: review.maskEmploye.convertString(), bool: review.maskEmploye))
        cell.setHalalCandy(applyMain(text: "halal_candy".localizedString, second: review.distancing.convertString(), bool: review.distancing))
    }
}
