//
//  StyleableView.swift
//  DeliveryAmp
//
//  Created by User on 7/26/17.
//
//

import Foundation
import UIKit

  /*
    init(subViewColor:UIColor,subViewMessage:String){
        
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowRadius = 10
        
        let frame = self.frame
        //Or you can use custom frame.
        
        super.init(frame: frame)
        
    }*/
    
@IBDesignable
class ViewWithShadow: UIView {
    
    
    /*override init (frame : CGRect) {
        super.init(frame : frame)
        dropShadow()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        dropShadow()
    }
    */
    func dropShadow() {
        
        
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: 1, height: 1)
        self.layer.shadowRadius = 4.0
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        //self.layer.shouldRasterize = true
        
        //self.layer.rasterizationScale = UIScreen.main.scale
        
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        dropShadow()
    }

}

/*
extension UIView {
    
    func dropShadow() {
        
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: 1, height: 1)
        self.layer.shadowRadius = 4.0
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.shouldRasterize = true
        
        self.layer.rasterizationScale = UIScreen.main.scale
        
    }
}*/
