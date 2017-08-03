//
//  FoodTypeTableViewCell.swift
//  DeliveryAmp
//
//  Created by User on 8/1/17.
//
//

import UIKit

class FoodTypeTableViewCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet weak var pizzaImage: UIImageView!
    @IBOutlet weak var foodNameLabel: UILabel!
    @IBOutlet weak var foodIngredientsLabel: UILabel!
    @IBOutlet weak var foodPriceLabel: UILabel!
    
    @IBOutlet weak var foodSizeScrollView: UIScrollView!
    @IBOutlet weak var crustTypeScrollView: UIScrollView!
    @IBOutlet weak var buttonsView: UIView!
    @IBOutlet weak var goToCustomizeButton: StyleableButton!
    @IBOutlet weak var addButton: StyleableButton!
    
    @IBOutlet weak var selectedType: UIView!
    
    @IBOutlet weak var foodSizeScrollViewHeightConstraint: NSLayoutConstraint!

    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func unhideViews() {
        foodSizeScrollView.isHidden = false
        crustTypeScrollView.isHidden = false
        buttonsView.isHidden = false
        selectedType.isHidden = false
        
        foodSizeScrollViewHeightConstraint.constant = 50

    }
    
    func hideViews() {
        foodSizeScrollView.isHidden = true
        crustTypeScrollView.isHidden = true
        buttonsView.isHidden = true
        selectedType.isHidden = true
        
        foodSizeScrollViewHeightConstraint.constant = 0

    }

}
