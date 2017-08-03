//
//  StyleableButton.swift
//  DeliveryAmp
//
//  Created by User on 7/26/17.
//
//

import Foundation
import UIKit

@IBDesignable
class StyleableButton : UIButton {
    
    let isSelectedBackgroundColor = MyColors.isSelectedButtonBackgroundColor
    let isSelectedBorderColor = MyColors.isSelectedButtonBackgroundColor
    let notSelectedBackgroundColor = UIColor.white
    var notSelectedBorderColor = UIColor.clear.cgColor
    
    
    @IBInspectable var cornerRadius : CGFloat = CGFloat() {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var borderColor : UIColor = UIColor.clear {
        didSet{
            layer.borderColor = borderColor.cgColor
            self.notSelectedBorderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var borderWidth : CGFloat = CGFloat() {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    override var isSelected: Bool {
        willSet(newValue) {
            super.isSelected = newValue;
            switchBackground()
        }
    }
    
    func switchBackground() {
        if self.isSelected {
            self.backgroundColor = isSelectedBackgroundColor
            self.layer.borderColor = isSelectedBorderColor.cgColor
        } else {
            self.tintColor = UIColor.white
            self.backgroundColor = notSelectedBackgroundColor
            self.layer.borderColor = notSelectedBorderColor
        }
    }

}
