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

    var selectedRowIndex = -1

    var selectedPizzaList: [[SelectedPizzaType]] = [[]]

    /*
    var allProducts: [Product]!
    var servingSizesFood: [ServingSize]!
    var allProductTypes: [ProductType]!
    var allIngredients: [Ingredient]!
*/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDelegates()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        selectedPizzaList.reserveCapacity(allProducts.count)
        for _ in 0...allProducts.count {
            selectedPizzaList.append([])
        }
        
        
        //foodTable.backgroundView?.addDiagonalGradient(self.view, [MyColors.darkBlue.cgColor, MyColors.lightBlue.cgColor], self.view.frame)

        //foodTable.backgroundColor = UIColor(red: 207/255, green: 231/255, blue: 241/255, alpha: 1)

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
        let destination = tabBarController?.viewControllers?[1] as! UINavigationController
        let createYourOwn = destination.topViewController as! CreateYourOwnViewController
        
        let indexPath = IndexPath(row: sender.tag, section: 0)
        let cell = foodTable.cellForRow(at: indexPath) as! FoodTypeTableViewCell
        
        _ = createYourOwn.view
        /*
        if #available(iOS 9.0, *) {
            createYourOwn.loadViewIfNeeded()
        } else {
            // Fallback on earlier versions
        }*/

        createYourOwn.usedIngredients = allIngredients.filter{allProducts[selectedRowIndex].ingredientIds.contains($0.id)}.map{($0, 0)}
        createYourOwn.selectedPizzaName.text = cell.foodNameLabel.text
        createYourOwn.selectedPizzaPrice.text = cell.foodPriceLabel.text
        createYourOwn.selectedPizzaPicture.image = cell.pizzaImage.image
        createYourOwn.selectedPizzaIngredients.text = cell.foodIngredientsLabel.text
        createYourOwn.ingredientsTable.reloadData()
        tabBarController!.selectedIndex = 1
      //  selectedRowIndex = -1 //optional
    }
    
}
