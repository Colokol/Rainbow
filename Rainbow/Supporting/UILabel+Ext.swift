//
//  UILabel+Ext.swift
//  Rainbow
//
//  Created by Валентина Попова on 13.11.2023.
//

import UIKit

extension UILabel {
    convenience init(text: String) {
        self.init()
        self.text = text
        self.font = .systemFont(ofSize: 15)
        self.textAlignment = .center
        self.textColor = .black
        self.numberOfLines = 0
        self.clipsToBounds = true
    }
}
