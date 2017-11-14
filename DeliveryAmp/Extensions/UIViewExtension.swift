//
//  UIViewExtension.swift
//  DeliveryAmp
//
//  Copyright © 2017 ThemeDimension.com
//

import UIKit

extension UIView {
    
    func addGradient(_ colors: [CGColor], _ frame: CGRect, _ index: Int) {
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors // top , bottom
        gradientLayer.locations = [0.0,1.0]
        gradientLayer.frame = frame
        
        self.layer.masksToBounds = false
        self.layer.insertSublayer(gradientLayer, at: UInt32(index))
    }
    
    func addDiagonalGradient(_ view: UIView, _ colors: [CGColor], _ frame: CGRect){
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors
        let gradientOffset = view.bounds.height / view.bounds.width / 2
        
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5 + gradientOffset)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5 - gradientOffset)
        gradientLayer.frame = frame
        
        view.layer.masksToBounds = false
        view.layer.insertSublayer(gradientLayer, at: 0)
        
    }
    
}
