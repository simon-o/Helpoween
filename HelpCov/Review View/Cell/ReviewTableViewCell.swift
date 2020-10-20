//
//  ReviewTableViewCell.swift
//  HelpCov
//
//  Created by Antoine Simon on 04/06/2020.
//  Copyright © 2020 Antoine Simon. All rights reserved.
//

import UIKit

class ReviewTableViewCell: UITableViewCell {

    @IBOutlet private weak var maskCustomerLabel: UILabel!
    @IBOutlet private weak var maskEmployeLabel: UILabel!
    @IBOutlet private weak var distancingLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundColor = UIColor.init(named: "ReviewCellColor")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setHaveCandy(_ text: NSAttributedString) {
        maskCustomerLabel.attributedText = text
    }
    func setVeganCandy(_ text: NSAttributedString) {
        maskEmployeLabel.attributedText = text
    }
    func setHalalCandy(_ text: NSAttributedString) {
        distancingLabel.attributedText = text
    }
}
