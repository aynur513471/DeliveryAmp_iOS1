//
//  SelectedPizzaType.swift
//  DeliveryAmp
//
//  Created by User on 8/1/17.
//
//

import UIKit

class SelectedPizzaType: UIView {

    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var removeButton: UIButton!
    
    @IBOutlet weak var contentView: UILabel!
    
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
