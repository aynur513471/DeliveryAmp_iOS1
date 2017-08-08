//
//  BeveragesTypeTableViewCell.swift
//  DeliveryAmp
//
//  Created by UserAdmin on 8/4/17.
//
//

import UIKit

class BeveragesTypeTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet weak var drinkImage: UIImageView!
    @IBOutlet weak var drinkNameLabel: UILabel!
    @IBOutlet weak var drinkIngredientsLabel: UILabel!
    @IBOutlet weak var drinkPriceLabel: UILabel!
    
    
    @IBOutlet weak var drinkSizeScrollView: UIScrollView!
    
    @IBOutlet weak var selectedTypeView: UIView!
    
    
    @IBOutlet weak var buttonsView: UIView!
    @IBOutlet weak var goToCustomizeButton: StyleableButton!
    @IBOutlet weak var addButton: StyleableButton!
    
    
    @IBOutlet weak var selectedTypeTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var selectedTypeBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var drinkSizeHeightContraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func unhideViews() {
        drinkSizeScrollView.isHidden = false
        buttonsView.isHidden = false
        selectedTypeView.isHidden = false
        
        
        drinkSizeHeightContraint.constant = 50
        selectedTypeTopConstraint.constant = 1
        selectedTypeBottomConstraint.constant = 1
        
        
    }
    
    func hideViews() {
        drinkSizeScrollView.isHidden = true
        buttonsView.isHidden = true
        selectedTypeView.isHidden = true
        
        drinkSizeHeightContraint.constant = 0
        selectedTypeTopConstraint.constant = 0
        selectedTypeBottomConstraint.constant = 0
    }
    
    @IBAction func selectDrinkSize(_ sender: StyleableButton) {
        deselectButtons(inside: drinkSizeScrollView)
        sender.isSelected = !sender.isSelected
        
        switch sender.tag {
            case 0:
                //print("0.25L")
                break
            case 1:
                //print("0.33L")
                break
            case 2:
                // print("0.5L")
                break
            case 3:
                // print("1.0L")
                break
            case 4:
                //print("2.0L")
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
    
    func getDrinkSize() -> Int {
        for subview in drinkSizeScrollView.subviews as [UIView] {
            if let btn = subview as? StyleableButton {
                if btn.isSelected {
                    return btn.tag
                }
            }
        }
        return -1
    }

}
