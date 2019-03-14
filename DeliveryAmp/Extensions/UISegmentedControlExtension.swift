//
//  UISegmentedControl.swift
//  DeliveryAmp
//
//  Copyright © 2017 ThemeDimension.com
//

import Foundation
import UIKit

extension UISegmentedControl {
    
    func changeTitleFont(newFontName:String?, newFontSize:CGFloat?){
        let attributedSegmentFont = NSDictionary(object: UIFont(name: newFontName!, size: newFontSize!)!, forKey: convertFromNSAttributedStringKey(NSAttributedString.Key.font) as NSCopying)
        setTitleTextAttributes(attributedSegmentFont as [NSObject : AnyObject] as [NSObject : AnyObject] as? [NSAttributedString.Key : Any], for: .normal)
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


// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromNSAttributedStringKey(_ input: NSAttributedString.Key) -> String {
	return input.rawValue
}
