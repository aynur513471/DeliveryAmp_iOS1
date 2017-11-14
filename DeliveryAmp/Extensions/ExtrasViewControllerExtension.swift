//
//  ExtrasViewControllerExtension.swift
//  DeliveryAmp
//
//  Copyright © 2017 ThemeDimension.com
//

import Foundation
import UIKit

extension ExtrasViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allExtras.count
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
           return CGFloat(123 + selectedExtrasList[indexPath.row].count * 35) // +3 from constraints
        }
        
        return 74.0// +3 from constraints + 1 to be equal with the other containers
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExtrasCell", for: indexPath) as! ExtrasTypeTableViewCell
        cell.selectionStyle = .none
        
        if indexPath.row != selectedRowIndex{
            cell.hideViews()
        }else{
            var yPosition = 0
            cell.selectedTypeView.subviews.forEach({$0.removeFromSuperview()})

            
            
            for subView in selectedExtrasList[indexPath.row] {
                subView.frame = CGRect(x: 0, y: yPosition, width: Int(cell.selectedTypeView.frame.size.width), height: 35)
                cell.selectedTypeView.addSubview(subView)
                cell.selectedTypeView.frame.size.height += 35
                yPosition += 35
                
            }
            cell.unhideViews()

        }
        
        cell.addButton.tag = indexPath.row
        populateCell(cell, indexPath.row)
        return cell
        
    }
    func populateCell(_ cell: ExtrasTypeTableViewCell, _ index: Int) {
   
        cell.extrasNameLabel.text = allExtras[index].name
        cell.extrasPriceLabel.text = Constants.currency + String(allExtras[index].price)
        cell.extrasIngredLabel.text = allExtras[index].extraDescription
        if let url = URL(string:  allExtras[index].imageUrl){
            cell.extrasImage.sd_setImage(
                with: url,
                placeholderImage: UIImage(named: "menu_icon.png"),
                options: [.continueInBackground, .progressiveDownload]
            )
            cell.extrasImage.contentMode = .scaleAspectFill
            cell.extrasImage.layer.cornerRadius = cell.extrasImage.frame.height / 2
            cell.extrasImage.clipsToBounds = true
        }else{
          
        }
        
        if #available(iOS 9.0, *) {
            cell.headerView.heightAnchor.constraint(equalToConstant: 70.0).isActive = true
        } else {
            // Fallback on earlier versions
        }
    }

    
    func buttonIsSelected(_ sender: StyleableButton) {
        deselectButtons(inside: sender.superview!)
        sender.isSelected = !sender.isSelected

    }
    
    func deselectButtons(inside view: UIView) {
        for subview in view.subviews as [UIView] {
            if let btn = subview as? StyleableButton {
                btn.isSelected = false
            }
        }
    }

    func getExtraDescription() -> String {
        return allExtras[selectedRowIndex].name
    }
    
    func getExtraPrice() -> String {
        return Constants.currency + String(allExtras[selectedRowIndex].price)
    }

    
}
