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
    
    var allProducts: [Product]!
    var servingSizesBeverages: [ServingSize]!
    var servingSizesFood: [ServingSize]!
    var allProductTypes: [ProductType]!
    var allIngredients: [Ingredient]!

    // MARK: - Outlets
    @IBOutlet weak var drinkTable: UITableView!
    
    // MARK: - Variables
    
    var thereIsCellTapped = false
    var selectedRowIndex = -1
    
    var selectedDrinkList: [[SelectedDrinkType]] = [[]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDelegates()
        
        selectedDrinkList.reserveCapacity(10)
        for _ in 0...10 {
            selectedDrinkList.append([])
        }
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
    @IBAction func goToCustomize(_ sender: StyleableButton) {
        tabBarController!.selectedIndex = 1
        selectedRowIndex = -1 //optional
    }

 

}
