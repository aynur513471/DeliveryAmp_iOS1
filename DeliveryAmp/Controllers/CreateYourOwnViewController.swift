//
//  CreateYourOwnViewController.swift
//  DeliveryAmp
//
//  Created by User on 7/27/17.
//
//

import UIKit

class CreateYourOwnViewController: UIViewController {

    
    // MARK: - Outlets
    
    @IBOutlet weak var selectedPizzaPicture: UIImageView!
    @IBOutlet weak var selectedPizzaName: UILabel!
    @IBOutlet weak var selectedPizzaIngredients: UILabel!
    @IBOutlet weak var selectedPizzaPrice: UILabel!

    @IBOutlet weak var pizzaTypesTable: UITableView!
    @IBOutlet weak var ingredientsTable: UITableView!
    
    @IBOutlet weak var pizzaSizeScrollView: UIScrollView!
    @IBOutlet weak var crustTypeScrollView: UIScrollView!

    
    // MARK: - Variables
    
    var usedIngredients: [(Ingredient, Int)] = []
    var selectedPizzaIndex = 0
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegates()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.view.addDiagonalGradient(self.view, [MyColors.darkBlue.cgColor, MyColors.lightBlue.cgColor], self.view.frame)
        self.view.layoutIfNeeded()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func setDelegates() {
        ingredientsTable.delegate = self
        ingredientsTable.dataSource = self
        
        pizzaTypesTable.delegate = self
        pizzaTypesTable.dataSource = self
    }
    
    // Mark: - Buttons functions
    
    @IBAction func changePizza(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            pizzaSizeScrollView.isHidden = true
            crustTypeScrollView.isHidden = true
            ingredientsTable.isHidden = true
            pizzaTypesTable.isHidden = false
        } else {
            ingredientsTable.reloadData()
            pizzaSizeScrollView.isHidden = false
            crustTypeScrollView.isHidden = false
            ingredientsTable.isHidden = false
            pizzaTypesTable.isHidden = true
        }
    }
    
    @IBAction func resetIngredients(_ sender: StyleableButton) {
        usedIngredients = usedIngredients.map{($0.0, 0)}
        ingredientsTable.reloadData()
        setPizzaPrice()
    }

}
