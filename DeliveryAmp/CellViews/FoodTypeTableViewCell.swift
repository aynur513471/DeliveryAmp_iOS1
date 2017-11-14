//
//  FoodTypeTableViewCell.swift
//  DeliveryAmp
//
//  Copyright © 2017 ThemeDimension.com
//

import UIKit

class FoodTypeTableViewCell: UITableViewCell {

    // MARK: - Outlets
    
    @IBOutlet weak var pizzaImage: UIImageView!
    @IBOutlet weak var foodNameLabel: UILabel!
    @IBOutlet weak var foodIngredientsLabel: UILabel!
    @IBOutlet weak var foodPriceLabel: UILabel!
    
    @IBOutlet weak var pizzaSizeScrollView: UIScrollView!
    @IBOutlet weak var crustTypeScrollView: UIScrollView!
    @IBOutlet weak var buttonsView: UIView!
    @IBOutlet weak var goToCustomizeButton: StyleableButton!
    @IBOutlet weak var addButton: StyleableButton!
    
    @IBOutlet weak var selectedType: UIView!
    
    @IBOutlet weak var pizzaSizeScrollViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var selectedTypeTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var selectedTypeBottomConstraint: NSLayoutConstraint!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func unhideViews() {
        pizzaSizeScrollView.isHidden = false
        crustTypeScrollView.isHidden = false
        buttonsView.isHidden = false
        selectedType.isHidden = false
        
        pizzaSizeScrollViewHeightConstraint.constant = 50
        selectedTypeTopConstraint.constant = 1
        selectedTypeBottomConstraint.constant = 1
    }
    
    func hideViews() {
        pizzaSizeScrollView.isHidden = true
        crustTypeScrollView.isHidden = true
        buttonsView.isHidden = true
        selectedType.isHidden = true
        
        pizzaSizeScrollViewHeightConstraint.constant = 0
        selectedTypeTopConstraint.constant = 0
        selectedTypeBottomConstraint.constant = 0
    }

    func getPizzaSize() -> Int {
        for subview in pizzaSizeScrollView.subviews as [UIView] {
            if let btn = subview as? StyleableButton {
                if btn.isSelected {
                    return btn.tag
                }
            }
        }
        return -1
    }
    
    func getCrustType() -> Int {
        for subview in crustTypeScrollView.subviews as [UIView] {
            if let btn = subview as? StyleableButton {
                if btn.isSelected {
                    return btn.tag
                }
            }
        }
        return -1
    }
    

}
