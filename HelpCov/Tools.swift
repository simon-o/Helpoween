//
//  Tools.swift
//  HelpCov
//
//  Created by Antoine Simon on 29/05/2020.
//  Copyright © 2020 Antoine Simon. All rights reserved.
//

import UIKit

extension String {
    var localizedString: String {
        return NSLocalizedString(self, comment: "")
    }
}

extension UISegmentedControl {
    func isTrue() -> Bool {
        return self.selectedSegmentIndex == 0
    }
}

extension Bool {
    func convertString() -> String {
        return self == true ? "yes_label".localizedString : "no_label".localizedString
    }
}

extension UIView {
    func addSubviewFillingParent(_ view: UIView, marginTop: CGFloat = 0, marginLeading: CGFloat = 0, marginBottom: CGFloat = 0, marginTrailing: CGFloat = 0) {
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        NSLayoutConstraint.activate([topAnchor.constraint(equalTo: view.topAnchor, constant: marginTop),
                                     trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: marginTrailing),
                                     bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: marginBottom),
                                     leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: marginLeading)])
    }
}
