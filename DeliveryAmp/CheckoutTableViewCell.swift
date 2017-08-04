//
//  CheckoutTableViewCell.swift
//  DeliveryAmp
//
//  Created by User on 7/28/17.
//
//

import UIKit

class OrderHistoryTableViewCell: UITableViewCell {

    @IBOutlet weak var addAsNewButton: StyleableButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        addAsNewButton.addTarget(OrderHistoryViewController(), action: #selector(OrderHistoryViewController.checkTouch), for: .touchUpInside)
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
