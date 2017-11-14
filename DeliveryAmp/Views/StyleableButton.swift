//
//  StyleableButton.swift
//  DeliveryAmp
//
//  Copyright © 2017 ThemeDimension.com
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
    
    override var isHighlighted: Bool {
        willSet(newValue) {
            super.isHighlighted = newValue;
            switchBackgroundHighlighted()
        }
    }
    
    func configureForScrollView() {
        self.cornerRadius = 15
        self.borderColor = MyColors.buttonBorderColor
        self.borderWidth = 1
        
        
        self.backgroundColor = UIColor.white
        self.titleLabel?.font = UIFont(name: "Roboto-Medium", size: CGFloat(11))
        self.setTitleColor(MyColors.buttonTextColor, for: .normal)
        self.setTitleColor(UIColor.white, for: .highlighted)
        self.setTitleColor(UIColor.white, for: .selected)
    }
    
    func switchBackgroundHighlighted() {
        if self.isHighlighted && !self.isSelected {
            self.backgroundColor = MyColors.buttonIsSelectedBackgroundColor
            self.layer.borderColor = MyColors.buttonIsSelectedBackgroundColor.cgColor
        }else if !self.isSelected{
            self.backgroundColor = MyColors.buttonDefaultBackgroundColor
            self.layer.borderColor = MyColors.buttonBorderColor.cgColor
        }
    }
    
    func switchBackground() {
        if self.isSelected && !self.isHighlighted{
            self.backgroundColor = MyColors.buttonIsSelectedBackgroundColor
            self.layer.borderColor = MyColors.buttonIsSelectedBackgroundColor.cgColor
        } else if !self.isHighlighted {
            self.tintColor = MyColors.buttonDefaultBackgroundColor
            self.backgroundColor = MyColors.buttonDefaultBackgroundColor
            self.layer.borderColor = MyColors.buttonBorderColor.cgColor
        }
        
    }
    
    
}
