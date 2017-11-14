//
//  StyleableView.swift
//  DeliveryAmp
//
//  Copyright © 2017 ThemeDimension.com
//

import Foundation
import UIKit

    
@IBDesignable
class ViewWithShadow: UIView {
    
    func dropShadow() {
        
        
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: 1, height: 1)
        self.layer.shadowRadius = 4.0
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        dropShadow()
    }

}

