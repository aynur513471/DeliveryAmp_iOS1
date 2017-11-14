//
//  SelectedDrinkType.swift
//  DeliveryAmp
//
//  Copyright © 2017 ThemeDimension.com
//

import UIKit

class SelectedDrinkType: UIView {

    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var removeButton: UIButton!

    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    class func fromNib<T : UIView>() -> T {
        super.awakeFromNib()
        return Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if self.superview != nil {
            self.frame.size.width = self.superview!.frame.size.width
            self.frame.size.height = 35
        }
    }
}
