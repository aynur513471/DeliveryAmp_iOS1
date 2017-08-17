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

    @IBOutlet weak var buttonsView: UIView!
    
    // MARK: - Variables
    
    var usedIngredients: [(Ingredient, Int)] = []
    var selectedPizzaIndex = 0
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegates()
    }

    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
        self.view.addDiagonalGradient(self.view, [MyColors.darkBlue.cgColor, MyColors.lightBlue.cgColor], self.view.frame)
        self.view.layoutIfNeeded()
        self.tabBarController?.tabBar.items![2].isEnabled = LocalRequest.checkOrder()
        
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
            
            buttonsView.isHidden = true
        } else {
            ingredientsTable.reloadData()
            pizzaSizeScrollView.isHidden = false
            crustTypeScrollView.isHidden = false
            ingredientsTable.isHidden = false
            pizzaTypesTable.isHidden = true
            
            buttonsView.isHidden = false
        }
    }
    
    @IBAction func resetIngredients(_ sender: StyleableButton) {
        usedIngredients = usedIngredients.map{($0.0, 0)}
        ingredientsTable.reloadData()
        setPizzaPrice()
    }

    @IBAction func addToOrder(_ sender: Any) {
        let crustId = getCrustType()
        let sizeId = getPizzaSize()
        let newItem = OrderItem()
        newItem.type = 0
        newItem.id = orderItemId
        
        newItem.product = allProducts.filter{$0.id == allProducts[selectedPizzaIndex].id}.map{product in OrderProduct(id: product.id, name: product.name, price: product.price)}[0]
        newItem.ingredients = usedIngredients.filter{$0.1 > 0}.map{ingredient in OrderIngredient(id: ingredient.0.id, name: ingredient.0.name, cost: ingredient.0.price, quantity: ingredient.1)}
  
        if newItem.ingredients.count > 0 {
            let size = servingSizesFood.filter{$0.id == sizeId}[0]
            let crust = allProductTypes.filter{$0.id == crustId}[0]
            newItem.productType = crust
            newItem.servingSize = size
            
            let ingredientsPrice = usedIngredients.reduce(0.0){$0 + ($1.0.price * Double($1.1))}
            newItem.cost = allProducts[selectedPizzaIndex].price + size.price + crust.price + ingredientsPrice
            
            orderItemId += 1
            order.items.append(newItem)
            
            Alert.showDefaultAlert(for: self, title: nil, message: "Custom pizza was added to your order!")
        } else {
            Alert.showDefaultAlert(for: self, title: nil, message: "No custom pizza was created!")
        }

        
    }
    
}
