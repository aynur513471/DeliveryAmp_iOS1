//
//  FoodViewControllerExtension.swift
//  DeliveryAmp
//
//  Created by User on 8/1/17.
//
//

import Foundation
import UIKit

extension FoodViewController: UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - table view functions
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FoodCell", for: indexPath) as! FoodTypeTableViewCell
        cell.selectionStyle = .none
        
        if indexPath.row != selectedRowIndex{
            cell.hideViews()
        }else{
            var yPosition = 0
            cell.selectedType.subviews.forEach({$0.removeFromSuperview()})
            
          /*
            for subView in cell.selectedType.subviews {
                if let _ = subView as? SelectedPizzaType {
                    subView.removeFromSuperview()
                }
            }*/
            
            for subView in selectedPizzaList[indexPath.row] {
                subView.frame = CGRect(x: 0, y: yPosition, width: Int(cell.selectedType.frame.size.width), height: 35)
                subView.removeButton.tag = yPosition / 35 //the tag represents the position of the view in vector
                cell.selectedType.addSubview(subView)
                cell.selectedType.frame.size.height += 35
                yPosition += 35
                
            }
            cell.unhideViews()
        }
        cell.goToCustomizeButton.tag = indexPath.row
        cell.addButton.tag = indexPath.row
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if selectedRowIndex == indexPath.row {
            selectedRowIndex = -1
        } else {
            selectedRowIndex = indexPath.row
        }
        
        tableView.reloadData()

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == selectedRowIndex  {     
            return CGFloat(173 + selectedPizzaList[indexPath.row].count * 35) // + 3 from constraints
        }

        return 71 // +1 from constraints
    }
    
    
    // MARK: - helpers functions
    
    func getPizzaDescription(_ pizzaSize: Int, _ crustType: Int) -> String {
        var description: String = ""
        switch pizzaSize {
        case 0:
            description = "Small"
            break
        case 1:
            description = "Medium"
            break
        case 2:
            description = "Large"
            break
        default:
            break
        }
        
        switch crustType {
        case 0:
            description.append(" + Thin Crust")
            break
        case 1:
            description.append(" + Thick Crust")
            break
        default:
            break
        }
        
        return description
    }
    
    func getPizzaPrice(_ pizzaSize: Int, _ crustType: Int) -> String {
        var price: Double = 0.0
        
        //it should get the price from a Pizza/Product object for the  given size and update it based on crust type
        switch pizzaSize {
        case 0:
            price = 10.0
            break
        case 1:
            price = 10.0
            break
        case 2:
            price = 10.0
            break
        default:
            break
        }
        
        switch crustType {
        case 0:
            price += 10.0
            break
        case 1:
            price += 10.0
            break
        default:
            break
        }
        
        return "$" + String(price)
    }
    
    
    
 
}
