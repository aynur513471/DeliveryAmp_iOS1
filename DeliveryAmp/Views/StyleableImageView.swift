//
//  StyleableImageView.swift
//  DeliveryAmp
//
//  Copyright © 2017 ThemeDimension.com
//

import UIKit

class StyleableImageView: UIImageView {
    override init (frame : CGRect) {
        super.init(frame : frame)
        makeRound()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        makeRound()
    }
    
    func makeRound() {
        
        layer.borderWidth = 1.0
        layer.masksToBounds = false
        layer.borderColor = UIColor.white.cgColor
        layer.cornerRadius = frame.size.width/2
        clipsToBounds = true
        
    }
}
