//
//  FoodViewControllerExtension.swift
//  DeliveryAmp
//
//  Copyright © 2017 ThemeDimension.com
//

import Foundation
import UIKit
import SDWebImage

extension FoodViewController: UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - table view functions
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allProducts.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    
        if selectedRowIndex == indexPath.row {
            selectedRowIndex = -1
            tableView.deselectRow(at: indexPath, animated: true)

            //tableView.scrollToRow(at: indexPath, at: .top, animated: true)
        } else {
            
            tableView.selectRow(at: indexPath, animated: true, scrollPosition: .none)
            selectedRowIndex = indexPath.row

        }
       //tableView.scrollToRow(at: indexPath, at: .none, animated: true)
        tableView.reloadData()
        tableView.scrollToRow(at: indexPath, at: .none, animated: true)

        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == selectedRowIndex  {
            return CGFloat(174 + selectedPizzaList[indexPath.row].count * 35) // +4 from constraints
        }
        
        return 74 // +4 from constraints
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        
        let cell = tableView.dequeueReusableCell(withIdentifier: "FoodCell", for: indexPath) as! FoodTypeTableViewCell
        cell.selectionStyle = .none
        
        if indexPath.row != selectedRowIndex{
            cell.hideViews()
        } else {
            var yPosition = 0
            cell.selectedType.subviews.forEach({$0.removeFromSuperview()})
            for subView in selectedPizzaList[indexPath.row] {
                subView.frame = CGRect(x: 0, y: yPosition, width: Int(cell.selectedType.frame.size.width), height: 35)
                cell.selectedType.addSubview(subView)
                cell.selectedType.frame.size.height += 35
                yPosition += 35
            }
            cell.unhideViews()
        }
        
        /* add buttons for size and crust type in their scrollViews */
        addButtonsForSize(allProducts[indexPath.row].sizeIds, to: cell.pizzaSizeScrollView, onRow: indexPath.row)
        addButtonsForCrust(allProducts[indexPath.row].crustIds, to: cell.crustTypeScrollView, onRow: indexPath.row)
        
        cell.goToCustomizeButton.tag = indexPath.row
        cell.addButton.tag = indexPath.row
        populateCell(cell, indexPath.row)
        return cell
    }
    
    
    func addButtonsForSize(_ sizeIds: [Int], to scrollView: UIScrollView, onRow row: Int) {
        var isFirst = true
        var xPosition = 10.0
        scrollView.subviews.forEach({$0.removeFromSuperview()})
        for id in sizeIds {
            let button = StyleableButton()
            button.configureForScrollView()
            button.isSelected = isFirst
            button.tag = id
            button.frame = CGRect.init(x: xPosition, y:10.0, width: 80.0, height: 30.0)
            
            button.setTitle(servingSizesFood.filter{$0.id == id}[0].name, for: .normal)
            button.addTarget(self, action: #selector(buttonIsSelected), for: .touchUpInside)
            scrollView.addSubview(button)
            xPosition += 90
            isFirst = false
        }
        scrollView.contentSize = CGSize(width: CGFloat(xPosition), height: scrollView.frame.size.height)
    }
    
    func addButtonsForCrust(_ crustIds: [Int], to scrollView: UIScrollView, onRow row: Int) {
        var isFirst = true
        var xPosition = 10.0
        scrollView.subviews.forEach({$0.removeFromSuperview()})
        for crustId in crustIds {
            let button = StyleableButton()
            button.configureForScrollView()
            button.isSelected = isFirst
            button.tag = crustId
            button.frame = CGRect.init(x: xPosition, y:10.0, width: 95.0, height: 30.0)
            
            button.setTitle(allProductTypes.filter{$0.id == crustId}[0].name, for: .normal)
            button.addTarget(self, action: #selector(buttonIsSelected), for: .touchUpInside)
            scrollView.addSubview(button)
            xPosition += 105
            isFirst = false
        }
        scrollView.contentSize = CGSize(width: CGFloat(xPosition), height: scrollView.frame.size.height)
    }

    
    func populateCell(_ cell: FoodTypeTableViewCell, _ index: Int) {
        let firstSizeId = allProducts[index].sizeIds[0]
        let firstCrustId = allProducts[index].crustIds[0]
        let sizePrice = servingSizesFood.filter{$0.id == firstSizeId}[0].price
        let crustPrice = allProductTypes.filter{$0.id == firstCrustId}[0].price
        
        cell.foodNameLabel.text = allProducts[index].name
        cell.foodPriceLabel.text = Constants.currency + String(allProducts[index].price + sizePrice + crustPrice)
        cell.foodIngredientsLabel.text = setIngredients(forIndex: index)
        if let url = URL(string:  allProducts[index].imageUrl){
            cell.pizzaImage.sd_setImage(
                with: url,
                placeholderImage: UIImage(named: "menu_icon.png"),
                options: [.continueInBackground, .progressiveDownload]
            )
            cell.pizzaImage.contentMode = .scaleAspectFill
            cell.pizzaImage.layer.cornerRadius = cell.pizzaImage.frame.height / 2
            cell.pizzaImage.clipsToBounds = true
            
        }else{
            //cell.pizzaImage.image =
        }
    }
    
  
    
    // MARK: - buttons selected
    
    @objc func buttonIsSelected(_ sender: StyleableButton) {
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
    
    func setPizzaPrice() {
        let cell = foodTable.cellForRow(at: IndexPath(row: selectedRowIndex, section: 0)) as! FoodTypeTableViewCell
        let sizeId = cell.getPizzaSize()
        let crustId = cell.getCrustType()
        let sizePrice = servingSizesFood.filter{$0.id == sizeId}[0].price
        let crustPrice = allProductTypes.filter{$0.id == crustId}[0].price
        cell.foodPriceLabel.text = Constants.currency + String(allProducts[selectedRowIndex].price + sizePrice + crustPrice)
    }

    
    // MARK: - helpers functions
    
    func getPizzaDescription(_ sizeId: Int, _ crustId: Int) -> String {
        return servingSizesFood.filter{$0.id == sizeId}[0].name + " + " + allProductTypes.filter{$0.id == crustId}[0].name
    }
    
    func getPizzaPrice(_ sizeId: Int, _ crustId: Int) -> String {
        let sizePrice = servingSizesFood.filter{$0.id == sizeId}[0].price
        let crustPrice = allProductTypes.filter{$0.id == crustId}[0].price
        return Constants.currency + String(allProducts[selectedRowIndex].price + sizePrice + crustPrice)
    }
    
    //Set Ingredients
    
    func setIngredients(forIndex index: Int) -> String{
        var ingredients = "Ingredients: "
        var first = true
        for ingredient in allIngredients { 
            if allProducts[index].ingredientIds.contains(ingredient.id) {
                if first {
                    ingredients += "\(ingredient.name)"
                    first = false
                }else {
                    ingredients += ", \(ingredient.name)"
                }
            }
        }
        return ingredients
    }

}
