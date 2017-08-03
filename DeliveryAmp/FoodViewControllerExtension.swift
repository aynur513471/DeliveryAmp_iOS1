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
    

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FoodCell", for: indexPath) as! FoodTypeTableViewCell
        cell.selectionStyle = .none
        
        if indexPath.row != selectedRowIndex{
            cell.hideViews()
        }else{
            var yPosition = 0
           // cell.selectedType.subviews.forEach({$0.removeFromSuperview()})
            
            for subView in cell.selectedType.subviews {
                if let _ = subView as? SelectedPizzaType {
                    subView.removeFromSuperview()
                }
            }
            
            for subView in selectedPizzaList[indexPath.row] {
                subView.frame = CGRect(x: 0, y: yPosition, width: Int(cell.selectedType.frame.size.width), height: 35)
                subView.removeButton.tag = yPosition / 35 //the tag represents the position of the view in vector
                
                subView.translatesAutoresizingMaskIntoConstraints = true
                //subView.addConstraints()
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
        
        let cell = tableView.cellForRow(at: indexPath) as! FoodTypeTableViewCell
        cell.unhideViews()
        
        cell.addButton.tag = indexPath.row
        for subView in selectedPizzaList[indexPath.row] {
            cell.selectedType.frame.size.height += 35
            cell.selectedType.addSubview(subView)
        }
        
        tableView.reloadData()

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == selectedRowIndex  {     
            return CGFloat(170 + selectedPizzaList[indexPath.row].count * 35)
        }

        return 70
    }
 
}
