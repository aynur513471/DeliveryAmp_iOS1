//
//  FoodViewController.swift
//  DeliveryAmp
//
//  Created by User on 8/1/17.
//
//

import UIKit

class FoodViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var foodTable: UITableView!
    
    // MARK: - Variables 
    
    var thereIsCellTapped = false
    var selectedRowIndex = -1

    var selectedPizzaList: [[SelectedPizzaType]] = [[]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDelegates()
        
        selectedPizzaList.reserveCapacity(10)
        for index in 0...10 {
            selectedPizzaList.append([])
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 
    func setDelegates() {
        self.foodTable.delegate = self
        self.foodTable.dataSource = self
    }
    

    // MARK: - Navigation

    @IBAction func addPizza(_ sender: UIButton) {
        
        let indexPath = IndexPath(row: sender.tag, section: 0)
        let myView: SelectedPizzaType = .fromNib()
        let cell = foodTable.cellForRow(at: indexPath) as! FoodTypeTableViewCell
        
        let pizzaSize = cell.getPizzaSize()
        let crustType = cell.getCrustType()
        
        if pizzaSize > -1 && crustType > -1 {
            myView.tag = sender.tag //the view will have the same tag with the cell
            myView.removeButton.tag = selectedPizzaList[(indexPath.row)].count  //the tag represents the position of the view in vector
            myView.removeButton.addTarget(self, action: #selector(removeView), for: .touchUpInside)
            
            myView.descriptionLabel.text = getPizzaDescription(pizzaSize, crustType)
            myView.priceLabel.text = getPizzaPrice(pizzaSize, crustType)
            
            selectedPizzaList[(indexPath.row)].append(myView)
            foodTable.reloadData()
        } else {
            Alert.showDefaultAlert(for: self, title: nil, message: "Please select a serving size and a crust type!")
        }

    }
    
    func removeView(sender: UIButton) {
        let index = sender.tag
        let cellIndex = sender.superview?.tag
        selectedPizzaList[(cellIndex)!].remove(at: index)
        foodTable.reloadData()
    }
    
    @IBAction func goToCustomize(_ sender: StyleableButton) {
      //  var allControllers = tabBarController?.viewControllers
      //  var destination = allControllers?[1] as! CreateYourOwnViewController
        
     //   destination.selectedPizzaName.text = "Dada"
        
        tabBarController!.selectedIndex = 1
        selectedRowIndex = -1 //optional
    }
    
}
