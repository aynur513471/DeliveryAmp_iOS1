//
//  StyleableSegmentedControl.swift
//  DeliveryAmp
//
//  Created by User on 8/7/17.
//

import UIKit

class StyleableSegmentedControl: UISegmentedControl {

    @IBInspectable var cornerRadius : CGFloat = CGFloat() {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var borderColor : UIColor = UIColor.clear {
        didSet{
            layer.borderColor = borderColor.cgColor
          
        }
    }
    
    @IBInspectable var borderWidth : CGFloat = CGFloat() {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
}
