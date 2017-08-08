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
    
    override var isSelected: Bool {
        willSet(newValue) {
            super.isSelected = newValue;
            switchBackground()
        }
    }
    
    func configureForScrollView() {
        self.cornerRadius = 15
        self.borderColor = MyColors.buttonBorderColor
        self.borderWidth = 1
        
        
        self.backgroundColor = UIColor.white
        self.titleLabel?.font = UIFont(name: "Roboto-Medium", size: CGFloat(11))
        self.setTitleColor(MyColors.buttonTextColor, for: .normal)
        self.setTitleColor(UIColor.white, for: .selected)

    }
    
    func switchBackground() {
        if self.isSelected {
            self.backgroundColor = MyColors.buttonIsSelectedBackgroundColor
            self.layer.borderColor = MyColors.buttonIsSelectedBackgroundColor.cgColor
        } else {
            self.tintColor = MyColors.buttonDefaultBackgroundColor
            self.backgroundColor = MyColors.buttonDefaultBackgroundColor
            self.layer.borderColor = MyColors.buttonBorderColor.cgColor
        }
    }

}
