//
//  UIStackView+Ext.swift
//  Rainbow
//
//  Created by Валентина Попова on 13.11.2023.
//

import UIKit

extension UIStackView {
    convenience init(views: [UIView],
                     axis: NSLayoutConstraint.Axis,
                     distribution: UIStackView.Distribution,
                     spacing: CGFloat,
                     alignment: UIStackView.Alignment = .fill) {
        self.init(arrangedSubviews: views)
        self.axis = axis
        self.distribution = distribution
        self.alignment = alignment
        self.spacing = spacing
    }
}
