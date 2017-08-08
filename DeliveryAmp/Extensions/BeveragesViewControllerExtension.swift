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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(allBeverages.count)
        return allBeverages.count
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
        
        /* add buttons for size and crust type in their scrollViews */
        addButtonsForSize(allBeverages[indexPath.row].sizeIds, to: cell.drinkSizeScrollView, onRow: indexPath.row)
        
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
            
            button.setTitle(servingSizesBeverages.filter{$0.id == id}[0].name, for: .normal)
            button.addTarget(self, action: #selector(buttonIsSelected), for: .touchUpInside)
            scrollView.addSubview(button)
            xPosition += 90
            isFirst = false
        }
        scrollView.contentSize = CGSize(width: CGFloat(xPosition), height: scrollView.frame.size.height)
    }
    
    func populateCell(_ cell: BeveragesTypeTableViewCell, _ index: Int) {
        let firstSizeId = allBeverages[index].sizeIds[0]
        let sizePrice = servingSizesBeverages.filter{$0.id == firstSizeId}[0].price
        
        cell.drinkNameLabel.text = allBeverages[index].name
        cell.drinkPriceLabel.text = Constants.currency + String(allBeverages[index].price + sizePrice)
        cell.drinkIngredientsLabel.text = allBeverages[index].beverageDescription
        if let url = URL(string:  allBeverages[index].imageUrl){
            cell.drinkImage.sd_setImage(
                with: url,
                placeholderImage: UIImage(named: "menu_icon.png"),
                options: [.continueInBackground, .progressiveDownload]
            )
        }else{
            
        }
    }

    
    
    
    // MARK: - buttons selected
    func buttonIsSelected(_ sender: StyleableButton) {
        deselectButtons(inside: sender.superview!)
        sender.isSelected = !sender.isSelected
        setDrinkPrice()
    }
    
    func deselectButtons(inside view: UIView) {
        for subview in view.subviews as [UIView] {
            if let btn = subview as? StyleableButton {
                btn.isSelected = false
            }
        }
    }
    
    func setDrinkPrice() {
        let cell = drinkTable.cellForRow(at: IndexPath(row: selectedRowIndex, section: 0)) as! BeveragesTypeTableViewCell
        let sizeId = cell.getDrinkSize()
        cell.drinkPriceLabel.text = Constants.currency + String(allBeverages[selectedRowIndex].price + servingSizesBeverages.filter{$0.id == sizeId}[0].price)
    }

    
    // MARK: - helpers functions
    
    func getDrinkDescription(_ sizeId: Int) -> String {
         return servingSizesBeverages.filter{$0.id == sizeId}[0].name
    }
    
    func getDrinkPrice(_ sizeId: Int) -> String {
        return "$" + String(allBeverages[selectedRowIndex].price + servingSizesBeverages.filter{$0.id == sizeId}[0].price)
    }

}
