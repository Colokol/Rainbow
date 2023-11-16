//
//  UIStackView+Ext.swift
//  Rainbow
//
//  Created by Валентина Попова on 13.11.2023.
//

import UIKit

extension UIStackView {
    convenience init(views: [UIView]) {
        self.init(arrangedSubviews: views)
        self.axis = .horizontal
        self.distribution = .equalSpacing
        self.alignment = .center
        self.spacing = 8
        self.backgroundColor = .white
        self.layer.cornerRadius = 15
        self.clipsToBounds = true
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layoutMargins = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        self.isLayoutMarginsRelativeArrangement = true
    }
}
