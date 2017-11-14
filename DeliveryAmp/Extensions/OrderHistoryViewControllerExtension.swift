//
//  OrderHistoryViewControllerExtension.swift
//  DeliveryAmp
//
//  Copyright © 2017 ThemeDimension.com
//

import Foundation
import UIKit

extension OrderHistoryViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == selectedRowIndex  {
            var ingredientsHeight = orderHistory[indexPath.row].items.reduce(0){$0 +  $1.ingredients.count}
            ingredientsHeight *= 35
            if ingredientsHeight > 0 {
                ingredientsHeight += 10
            }
            return CGFloat(240 + orderHistory[indexPath.row].items.count * 35 + ingredientsHeight)
        }
        
        return 50
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderHistory.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if selectedRowIndex == indexPath.row {
            selectedRowIndex = -1
        } else {
            selectedRowIndex = indexPath.row
        }
        
        tableView.reloadData()
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "order", for: indexPath) as! OrderHistoryTableViewCell
        cell.selectionStyle = .none
        cell.addAsNewButton.tag = indexPath.row

        if indexPath.row != selectedRowIndex{
            cell.hideDetailsView()
        } else {
            cell.itemsView.subviews.forEach({$0.removeFromSuperview()})
            var yPosition = 0
            for item in orderHistory.reversed()[indexPath.row].items {
                let itemView: SelectedPizzaType = .fromNib()
                itemView.frame = CGRect(x: 0 , y: yPosition, width: Int(cell.itemsView.frame.size.width), height: 35)
                customizeItemView(itemView: itemView, item: item)
                yPosition += 35
                for ingredient in item.ingredients {
                    let ingredientView: SelectedPizzaType = .fromNib()
                    ingredientView.frame = CGRect(x: 10, y: yPosition, width: 250, height: 35)
                    ingredientView.isSubview = true
                    customizeIngredientView(ingredientView: ingredientView, ingredient: ingredient)
                    yPosition += 35
                    itemView.addSubview(ingredientView)
                    itemView.frame.size.height += CGFloat(yPosition)
                    itemView.layoutIfNeeded()
                }
                cell.itemsView.addSubview(itemView)
                cell.itemsView.layoutIfNeeded()
            }
            cell.itemsView.frame.size.height += CGFloat(yPosition )
            cell.showDetailsView()
        }
        populateCell(cell: cell, order: orderHistory.reversed()[indexPath.item])
        return cell
    }
    
    func populateCell(cell: OrderHistoryTableViewCell, order: Order) {
        cell.orderDateLabel.text = order.date
        cell.firstNameTextField.text = order.firstName
        cell.lastNameTextField.text = order.lastName
        cell.phoneTextField.text = order.phone
        cell.mailAddressTextField.text = order.email
        cell.addressTextField.text = order.address
        cell.orderPriceLabel.text = Constants.currency + String(order.totalCost)
    }
    
    
    func customizeItemView(itemView: SelectedPizzaType, item: OrderItem) {
        itemView.removeButtonWidthConstraint.constant = 0
        
        if item.type == 0 {
            if item.ingredients.count > 0 {
                itemView.descriptionLabel.text = "(C) " + item.product.name + " " + item.productType.name + " + " + item.servingSize.name
            } else {
                itemView.descriptionLabel.text = item.product.name + " " + item.productType.name + " + " + item.servingSize.name
            }
        } else if item.type == 1 {
            itemView.descriptionLabel.text = item.product.name + " " + item.servingSize.name
        } else {
            itemView.descriptionLabel.text = item.product.name
        }
        
        itemView.priceLabel.text = Constants.currency + String(item.cost)
    }
    
    func customizeIngredientView(ingredientView: SelectedPizzaType, ingredient: OrderIngredient) {
        ingredientView.removeButtonWidthConstraint.constant = 0
        ingredientView.layoutIfNeeded()
        ingredientView.descriptionLabel.text = String(ingredient.quantity) + " x " +  ingredient.name
        ingredientView.priceLabel.text = Constants.currency +  String(ingredient.cost)
        ingredientView.backgroundColor = MyColors.ingredientViewColor
    }
   
    
}
