//
//  StyleableTextField.swift
//  DeliveryAmp
//
//  Copyright © 2017 ThemeDimension.com
//

import Foundation
import UIKit

@IBDesignable
class StyleableTextField : UITextField{
    
  
    //designs
    
    var bottomBorderColor = UIColor()
    
    @IBInspectable var cornerRadius : CGFloat = CGFloat() {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var borderColor: UIColor = UIColor.clear {
        didSet {
            layer.borderColor = borderColor.cgColor
            
        }
    }
    
    @IBInspectable var borderWidth : CGFloat = CGFloat() {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    func setBottomBorder(_ color: UIColor){
        borderColor = color
    }
   
}
