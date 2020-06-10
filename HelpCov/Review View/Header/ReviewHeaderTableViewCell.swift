//
//  ReviewHeaderTableViewCell.swift
//  HelpCov
//
//  Created by Antoine Simon on 04/06/2020.
//  Copyright © 2020 Antoine Simon. All rights reserved.
//

import UIKit

class ReviewHeaderTableViewCell: UITableViewHeaderFooterView {

    @IBOutlet private weak var titleLabel: UILabel!
    
    var closedPressed: (() -> Void)?
    
    override func awakeFromNib() {
        layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        layer.shadowOpacity = 1.0
        layer.shadowRadius = 10
    }
    func setTitle(_ text: String) {
        titleLabel.text = text
    }
    
    @IBAction func closePressed(_ sender: Any) {
        closedPressed?()
    }
}
