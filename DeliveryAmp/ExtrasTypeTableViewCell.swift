//
//  ExtrasTypeTableViewCell.swift
//  DeliveryAmp
//
//  Created by UserAdmin on 8/9/17.
//
//

import UIKit

class ExtrasTypeTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var extrasImage: UIImageView!
    @IBOutlet weak var extrasNameLabel: UILabel!
    @IBOutlet weak var extrasIngredLabel: UILabel!
    @IBOutlet weak var extrasPriceLabel: UILabel!
    
    @IBOutlet weak var buttonsView: UIView!
    @IBOutlet weak var addButton: StyleableButton!
    
    @IBOutlet weak var selectedTypeView: UIView!
    
    @IBOutlet weak var headerView: UIView!
    
    @IBOutlet weak var selectedTypeBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var selectedTypeTopConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var bottonsViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var viewWithShadow: ViewWithShadow!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func unhideViews() {
        
        selectedTypeView.isHidden = false
        bottonsViewHeightConstraint.constant = 50
        
     //   if selectedTypeTopConstraint != nil  && selectedTypeBottomConstraint != nil {
            selectedTypeTopConstraint.constant = 1
            selectedTypeBottomConstraint.constant = 1
            
     //   }
        self.layoutIfNeeded()
    }
    
    func hideViews() {
        
        selectedTypeView.isHidden = true
        bottonsViewHeightConstraint.constant = 0
      //  if selectedTypeTopConstraint != nil  && selectedTypeBottomConstraint != nil {
           // selectedTypeTopConstraint.constant = 0
            selectedTypeBottomConstraint.constant = 0
   //     }
        self.layoutIfNeeded()
    }
    
    
    
    
    func deselectButtons(inside view: UIView) {
        for subview in view.subviews as [UIView] {
            if let btn = subview as? StyleableButton {
                btn.isSelected = false
            }
        }
    }
    
    
}
