//
//  CheckoutTableViewCell.swift
//  DeliveryAmp
//
//  Copyright © 2017 ThemeDimension.com
//

import UIKit

class OrderHistoryTableViewCell: UITableViewCell {

    @IBOutlet weak var orderDetailsView: UIView!
    @IBOutlet weak var itemsView: UIView!
    
    @IBOutlet weak var addAsNewButton: StyleableButton!
    @IBOutlet weak var orderDateLabel: UILabel!
    @IBOutlet weak var orderPriceLabel: UILabel!
    @IBOutlet weak var firstNameTextField: StyleableTextField!
    @IBOutlet weak var lastNameTextField: StyleableTextField!
    @IBOutlet weak var phoneTextField: StyleableTextField!
    @IBOutlet weak var mailAddressTextField: StyleableTextField!
    
    @IBOutlet weak var addressTextField: StyleableTextField!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func hideDetailsView() {
        orderDetailsView.frame.size.height = 0
        orderDetailsView.clipsToBounds = true
        
    }
    
    func showDetailsView() {
        orderDetailsView.frame.size.height = 160
    }
    
}
