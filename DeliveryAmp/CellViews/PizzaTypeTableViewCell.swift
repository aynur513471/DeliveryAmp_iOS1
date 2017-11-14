//
//  PizzaTypeTableViewCell.swift
//  DeliveryAmp
//
//  Copyright © 2017 ThemeDimension.com
//

import UIKit

class PizzaTypeTableViewCell: UITableViewCell {

    
    //MARK - Outlets
    
    @IBOutlet weak var pizzaPicture: UIImageView!
    @IBOutlet weak var pizzaName: UILabel!
    @IBOutlet weak var pizzaIngredients: UILabel!
    @IBOutlet weak var pizzaPrice: UILabel!
    @IBOutlet weak var selectedIndicator: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
