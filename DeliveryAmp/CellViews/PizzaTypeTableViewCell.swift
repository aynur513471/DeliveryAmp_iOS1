//
//  PizzaTypeTableViewCell.swift
//  DeliveryAmp
//
//  Created by User on 7/31/17.
//
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
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
