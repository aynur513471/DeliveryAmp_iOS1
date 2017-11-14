//
//  IngredientTableViewCell.swift
//  DeliveryAmp
//
//  Copyright © 2017 ThemeDimension.com
//

import UIKit

class IngredientTableViewCell: UITableViewCell {

    //MARK - Outlets
    
    @IBOutlet weak var ingredientLabel: UILabel!
    @IBOutlet weak var ingredientPriceLabel: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var ingredientTotalPriceLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    //MARK - Stepper function
    
    @IBAction func modifyAmount(_ sender: UIStepper) {
        if let price = ingredientPriceLabel.text?.components(separatedBy: "$")[1] {
            amountLabel.text = Int(sender.value).description
            ingredientTotalPriceLabel.text = "$" + String(Double(sender.value) * Double(price)!)
        }
    }
}
