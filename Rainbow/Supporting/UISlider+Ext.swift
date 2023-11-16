//
//  UISlider+Ext.swift
//  Rainbow
//
//  Created by Валентина Попова on 13.11.2023.
//

import UIKit

extension UISlider {
    convenience init(maximumValue: Float, value: Float) {
        self.init()
        self.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
        self.minimumValue = 1
        self.maximumValue = maximumValue
        self.isContinuous = true
        self.tintColor = .orange
        self.value = value
    }
}
