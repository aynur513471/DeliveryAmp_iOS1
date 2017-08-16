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

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.tag == 0 {
            return usedIngredients.count
        } else {
            return allProducts.count
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView.tag != 0 {
            let cell = tableView.cellForRow(at: indexPath) as! PizzaTypeTableViewCell
            
            selectedPizzaIndex = indexPath.row
            
            addButtonsForSize()
            addButtonsForCrust()
            
            selectedPizzaPicture.image = cell.pizzaPicture.image
            selectedPizzaName.text = cell.pizzaName.text
            selectedPizzaIngredients.text = cell.pizzaIngredients.text
            selectedPizzaPrice.text = cell.pizzaPrice.text
            
            usedIngredients = allIngredients.filter{allProducts[indexPath.row].ingredientIds.contains($0.id)}.map{($0, 0)}
            
            cell.selectedIndicator.backgroundColor = UIColor.orange
            
            Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(CreateYourOwnViewController.toggleIndicator(_:)), userInfo:  cell.selectedIndicator, repeats: false)
            
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView.tag == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "IngredientCell", for: indexPath) as! IngredientTableViewCell
            cell.stepper.tag = indexPath.row
            cell.stepper.addTarget(self, action: #selector(modifyAmount), for: .valueChanged)
            populateIngredientCell(cell, indexPath.row)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PizzaCell", for: indexPath) as! PizzaTypeTableViewCell
            populatePizzaCell(cell, indexPath.row)
            return cell
        }
    }
    
    // MARK: - TableViewCell functions
    
    func populatePizzaCell(_ cell: PizzaTypeTableViewCell, _ index: Int) {
        let firstSizeId = allProducts[index].sizeIds[0]
        let firstCrustId = allProducts[index].crustIds[0]
        let sizePrice = servingSizesFood.filter{$0.id == firstSizeId}[0].price
        let crustPrice = allProductTypes.filter{$0.id == firstCrustId}[0].price
        
        cell.pizzaName.text = allProducts[index].name
        cell.pizzaPrice.text = Constants.currency + String(allProducts[index].price + sizePrice + crustPrice)
        cell.pizzaIngredients.text = allProducts[index].productDescription
        if let url = URL(string:  allProducts[index].imageUrl){
            cell.pizzaPicture.sd_setImage(
                with: url,
                placeholderImage: UIImage(named: "menu_icon.png"),
                options: [.continueInBackground, .progressiveDownload]
            )
        }else{
            //cell.pizzaImage.image =
        }
    }
    
    func populateIngredientCell(_ cell: IngredientTableViewCell, _ index: Int) {
        cell.amountLabel.text = "0"
        cell.ingredientTotalPriceLabel.text = "$0"
        
        cell.amountLabel.text = String(usedIngredients[index].1)
        cell.ingredientLabel.text = usedIngredients[index].0.name
        
        cell.ingredientPriceLabel.text = Constants.currency + String(usedIngredients[index].0.price)
        cell.ingredientTotalPriceLabel.text = Constants.currency + String(usedIngredients[index].0.price * Double(usedIngredients[index].1))
        cell.stepper.value = Double(usedIngredients[index].1)

    }
    
    
    func addButtonsForSize() {
        var isFirst = true
        var xPosition = 10.0
        pizzaSizeScrollView.subviews.forEach({$0.removeFromSuperview()})
        for id in  allProducts[selectedPizzaIndex].sizeIds {
            let button = StyleableButton()
            button.configureForScrollView()
            button.isSelected = isFirst
            button.tag = id
            button.frame = CGRect.init(x: xPosition, y:10.0, width: 80.0, height: 30.0)
 
            button.setTitle(servingSizesFood.filter{$0.id == id}[0].name, for: .normal)
            button.addTarget(self, action: #selector(buttonIsSelected), for: .touchUpInside)
            pizzaSizeScrollView.addSubview(button)
            xPosition += 90
            isFirst = false
        }
        pizzaSizeScrollView.contentSize = CGSize(width: CGFloat(xPosition), height: pizzaSizeScrollView.frame.size.height)
    }
    

    
    func addButtonsForCrust() {
        var isFirst = true
        var xPosition = 10.0
        crustTypeScrollView.subviews.forEach({$0.removeFromSuperview()})
        for crustId in allProducts[selectedPizzaIndex].crustIds {
            let button = StyleableButton()
            button.configureForScrollView()
            button.isSelected = isFirst
            button.tag = crustId
            button.frame = CGRect.init(x: xPosition, y:10.0, width: 95.0, height: 30.0)
            
            button.setTitle(allProductTypes.filter{$0.id == crustId}[0].name, for: .normal)
            button.addTarget(self, action: #selector(buttonIsSelected), for: .touchUpInside)
            crustTypeScrollView.addSubview(button)
            xPosition += 105
            isFirst = false
        }
        crustTypeScrollView.contentSize = CGSize(width: CGFloat(xPosition), height: crustTypeScrollView.frame.size.height)
    }
    
    
    // MARK: - Button functions
    
    func buttonIsSelected(_ sender: StyleableButton) {
        deselectButtons(inside: sender.superview!)
        sender.isSelected = !sender.isSelected
        setPizzaPrice()
    }
    
    func deselectButtons(inside view: UIView) {
        for subview in view.subviews as [UIView] {
            if let btn = subview as? StyleableButton {
                btn.isSelected = false
            }
        }
    }
    
    // Mark: - Functions for labels 
    
    func setPizzaPrice() {
        let sizeId = getPizzaSize()
        let crustId = getCrustType()
        let sizePrice = servingSizesFood.filter{$0.id == sizeId}[0].price
        let crustPrice = allProductTypes.filter{$0.id == crustId}[0].price    
        var ingredientsPrice = usedIngredients.reduce(0.0){$0 + ($1.0.price * Double($1.1))}
        selectedPizzaPrice.text = Constants.currency + String(allProducts[selectedPizzaIndex].price + sizePrice + crustPrice + ingredientsPrice)
    }

    

    
    func modifyAmount(_ sender: UIStepper) {
        let amountDifference = Int(sender.value) - usedIngredients[sender.tag].1
        let oldPrice = Double((selectedPizzaPrice.text?.components(separatedBy: "$")[1])!)!
        let priceDifference = Double(amountDifference) * usedIngredients[sender.tag].0.price
        usedIngredients[sender.tag].1 = Int(sender.value)
        
        selectedPizzaPrice.text = Constants.currency + String(oldPrice + priceDifference)
    }
    
    
    // MARK: - Helping functions
    
    
    /* indicator for selected cell */
    func toggleIndicator(_ timer : Timer) {
        let selectedIndicator = timer.userInfo as! UIView
        selectedIndicator.backgroundColor = UIColor.white
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
