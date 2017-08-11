//
//  BeveragesViewController.swift
//  DeliveryAmp
//
//  Created by User on 8/1/17.
//
//

import UIKit

class BeveragesViewController: UIViewController {
    
    // MARK: - Variables
    
    // MARK: - Outlets
    @IBOutlet weak var drinkTable: UITableView!
    
    // MARK: - Variables
    
    var thereIsCellTapped = false
    var selectedRowIndex = -1
    
    var selectedDrinkList: [[SelectedDrinkType]] = [[]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDelegates()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        selectedDrinkList.reserveCapacity(allBeverages.count)
        for _ in 0...allBeverages.count {
            selectedDrinkList.append([])
        }
        
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setDelegates() {
        self.drinkTable.delegate = self
        self.drinkTable.dataSource = self
    }
    
    
    // MARK: - Navigation
    
    @IBAction func addDrink(_ sender: UIButton) {
        
        let indexPath = IndexPath(row: sender.tag, section: 0)
        let myView: SelectedDrinkType = .fromNib()
        let cell = drinkTable.cellForRow(at: indexPath) as! BeveragesTypeTableViewCell
        
        let drinkSize = cell.getDrinkSize()

        
        if drinkSize > -1 {
            myView.tag = sender.tag
            myView.removeButton.tag = selectedDrinkList[(indexPath.row)].count
            myView.removeButton.addTarget(self, action: #selector(removeView), for: .touchUpInside)
            
            myView.descriptionLabel.text = getDrinkDescription(drinkSize)
            myView.priceLabel.text = getDrinkPrice(drinkSize)
            
            selectedDrinkList[(indexPath.row)].append(myView)
            drinkTable.reloadData()
        } else {
            Alert.showDefaultAlert(for: self, title: nil, message: "Please select a serving size!")
        }
        
    }
    
    func removeView(sender: UIButton) {
        let index = sender.tag
        let cellIndex = sender.superview?.tag
        selectedDrinkList[(cellIndex)!].remove(at: index)
        drinkTable.reloadData()
    }
    
   

 

}
