//
//  BeveragesViewControllerExtension.swift
//  DeliveryAmp
//
//  Created by User on 8/1/17.
//
//

import Foundation
import UIKit

extension BeveragesViewController: UITableViewDelegate, UITableViewDataSource {
    // MARK: - table view functions
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DrinkCell", for: indexPath) as! BeveragesTypeTableViewCell
        cell.selectionStyle = .none
        
        if indexPath.row != selectedRowIndex{
            cell.hideViews()
        }else{
            var yPosition = 0
            cell.selectedTypeView.subviews.forEach({$0.removeFromSuperview()})
            
            
            for subView in selectedDrinkList[indexPath.row] {
                subView.frame = CGRect(x: 0, y: yPosition, width: Int(cell.selectedTypeView.frame.size.width), height: 35)
                subView.removeButton.tag = yPosition / 35 //the tag represents the position of the view in vector
                cell.selectedTypeView.addSubview(subView)
                cell.selectedTypeView.frame.size.height += 35
                yPosition += 35
                
            }
            cell.unhideViews()
        }
   
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
            return CGFloat(173 + selectedDrinkList[indexPath.row].count * 35) // + 3 from constraints
        }
        
        return 71 // +1 from constraints
    }
    
    
    // MARK: - helpers functions
    
    func getDrinkDescription(_ drinkSize: Int) -> String {
        var description: String = ""
        switch drinkSize {
        case 0:
            description = "0.25L"
            break
        case 1:
            description = "0.33L"
            break
        case 2:
            description = "0.5L"
            break
        case 3:
            description = "1.0L"
            break
        case 4:
            description = "2.0L"
            break
        default:
            break
        }
        
        
        return description
    }
    
    func getDrinkPrice(_ drinkSize: Int) -> String {
        var price: Double = 0.0
        
        switch drinkSize {
        case 0:
            price = 2.99
            break
        case 1:
            price = 3.99
            break
        case 2:
            price = 4.99
            break
        case 3:
            price = 5.99
            break
        case 4:
            price = 7.99
            break
        default:
            break
        }
       
        
        return "$" + String(price)
    }
}
