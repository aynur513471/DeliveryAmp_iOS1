//
//  CreateYourOwnViewControllerExtension.swift
//  DeliveryAmp
//
//  Created by User on 7/27/17.
//
//

import Foundation
import UIKit


extension CreateYourOwnViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    // MARK - TableView functions
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView.tag == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "IngredientCell", for: indexPath) as! IngredientTableViewCell
            cell.amountLabel.text = "0"
            cell.ingredientTotalPriceLabel.text = "0"
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PizzaCell", for: indexPath) as! PizzaTypeTableViewCell
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.tag == 0 {
            return 15
        } else {
            return 10
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView.tag != 0 {
            let cell = tableView.cellForRow(at: indexPath) as! PizzaTypeTableViewCell
        
            selectedPizzaPicture.image = cell.pizzaPicture.image
            selectedPizzaName.text = cell.pizzaName.text
            selectedPizzaIngredients.text = cell.pizzaIngredients.text
            selectedPizzaPrice.text = cell.pizzaPrice.text
        
            cell.selectedIndicator.backgroundColor = UIColor.orange
        
            Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(CreateYourOwnViewController.toggleIndicator(_:)), userInfo:  cell.selectedIndicator, repeats: false)
        }
    }
    
    
    func toggleIndicator(_ timer : Timer) {
        let selectedIndicator = timer.userInfo as! UIView
        selectedIndicator.backgroundColor = UIColor.white
    }
    

}
