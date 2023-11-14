//
//  UILabel+Ext.swift
//  Rainbow
//
//  Created by Валентина Попова on 13.11.2023.
//

import UIKit

extension UILabel {
    convenience init(text: String, font: UIFont) {
        self.init()
        self.text = text
        self.font = font
        self.textAlignment = .center
        self.textColor = .black
        self.clipsToBounds = true
    }
}
