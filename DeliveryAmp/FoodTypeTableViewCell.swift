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

        // Configure the view for the selected state
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
    
    @IBAction func selectPizzaSize(_ sender: StyleableButton) {
        deselectButtons(inside: pizzaSizeScrollView)
        sender.isSelected = !sender.isSelected
        
        
        /* here i will assign the size to my object*/
        switch sender.tag {
        case 0:
            //print("small")
            break
        case 1:
            //print("medium")
            break
        case 2:
            // print("large")
            break
        default:
            break
        }
    }
    
    
    @IBAction func selectCrustType(_ sender: UIButton) {
        deselectButtons(inside: crustTypeScrollView)
        sender.isSelected = !sender.isSelected
        
        /* here i will assign the crust type to my object*/
        switch sender.tag {
        case 0:
            //print("thin")
            break
        case 1:
            // print("thick")
            break
        default:
            break
        }
    }
    
    func deselectButtons(inside view: UIView) {
        for subview in view.subviews as [UIView] {
            if let btn = subview as? StyleableButton {
                btn.isSelected = false
            }
        }
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
        for subview in pizzaSizeScrollView.subviews as [UIView] {
            if let btn = subview as? StyleableButton {
                if btn.isSelected {
                    return btn.tag
                }
            }
        }
        return -1
    }
    

}
