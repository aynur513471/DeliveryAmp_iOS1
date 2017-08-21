//
//  UISegmentedControl.swift
//  DeliveryAmp
//
//  Created by User on 8/17/17.
//
//

import Foundation
import UIKit

extension UISegmentedControl {
    
    func changeTitleFont(newFontName:String?, newFontSize:CGFloat?){
        let attributedSegmentFont = NSDictionary(object: UIFont(name: newFontName!, size: newFontSize!)!, forKey: NSFontAttributeName as NSCopying)
        setTitleTextAttributes(attributedSegmentFont as [NSObject : AnyObject], for: .normal)
    }
    
    func customizeSegmentedControl() {
        layer.cornerRadius = 15 // Don't let background bleed
        layer.borderWidth = 1
        layer.borderColor = MyColors.buttonBorderColor.cgColor
        backgroundColor = UIColor.white
        tintColor = MyColors.buttonTextColor
        clipsToBounds = true
    }
    
}

