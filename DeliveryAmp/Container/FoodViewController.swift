//
//  FoodViewController.swift
//  DeliveryAmp
//
//  Copyright © 2017 ThemeDimension.com
//

import UIKit

class FoodViewController: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var foodTable: UITableView!
    
    // MARK: - Variables 

    var selectedRowIndex = -1
    var selectedPizzaList: [[SelectedPizzaType]] = [[]]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegates()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        selectedPizzaList = [[]]
        selectedPizzaList.reserveCapacity(allProducts.count)
        for _ in 0...allProducts.count {
            selectedPizzaList.append([])
        }

       // self.tabBarController?.tabBar.items![2].isEnabled = LocalRequest.checkOrder()
        tabBarController?.setTextAtributes()

      
        for item in order.items {
            if item.type == 0 {
                let view: SelectedPizzaType = .fromNib()
                view.descriptionLabel.text = item.productType.name + " + " + item.servingSize.name
                view.priceLabel.text = "₽" + String(item.cost)
                view.removeButton.tag = item.id
                view.removeButton.addTarget(self, action: #selector(removeView), for: .touchUpInside)
                for (index, product) in allProducts.enumerated() {
                    if product.id == item.product.id {
                        selectedPizzaList[index].append(view)
                    }
                }
            }
            
        }
        
        foodTable.reloadData()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
 
    func setDelegates() {
        self.foodTable.delegate = self
        self.foodTable.dataSource = self
    }
    

    // MARK: - Buttons functions

    @IBAction func addPizza(_ sender: UIButton) {
        
        let indexPath = IndexPath(row: sender.tag, section: 0)
        let myView: SelectedPizzaType = .fromNib()
        let cell = foodTable.cellForRow(at: indexPath) as! FoodTypeTableViewCell
        
        cell.crustTypeScrollView.contentOffset = CGPoint.zero
        cell.pizzaSizeScrollView.contentOffset = CGPoint.zero
        
        let pizzaSize = cell.getPizzaSize()
        let crustType = cell.getCrustType()
        
        if pizzaSize > -1 && crustType > -1 {
            myView.tag = sender.tag //the view will have the same tag with the cell
            myView.removeButton.tag = orderItemId
            myView.removeButton.addTarget(self, action: #selector(removeView), for: .touchUpInside)
            
            myView.descriptionLabel.text = getPizzaDescription(pizzaSize, crustType)
            myView.priceLabel.text = getPizzaPrice(pizzaSize, crustType)

            selectedPizzaList[(indexPath.row)].append(myView)
          
            foodTable.reloadData()
            
            addToOrder(allProducts[sender.tag].id, pizzaSize, crustType)
            
        } else {
            Alert.showDefaultAlert(for: self, title: nil, message: "Пожалуйста, выберите размер порции и тип корочки!")
        }
    }
    
    func addToOrder(_ productId: Int, _ pizzaSize: Int, _ crustType: Int) {
        let newItem = OrderItem()
        newItem.type = 0
        newItem.id = orderItemId
        newItem.product = allProducts.filter{$0.id == productId}.map{product in OrderProduct(id: product.id, name: product.name, price: product.price)}[0]
        newItem.ingredients = []
        newItem.productType = allProductTypes.filter{$0.id == crustType}[0]
        newItem.servingSize = servingSizesFood.filter{$0.id == pizzaSize}[0]
        newItem.cost = Double(getPizzaPrice(pizzaSize, crustType).components(separatedBy: "₽")[1])!
        
        orderItemId = OrderHelper.getNextOrderId()
        order.items.append(newItem)
        
        tabBarController?.setTextAtributes()

    }

    
    @objc func removeView(sender: UIButton) {
        let viewId = sender.tag
        if let cellIndex = sender.superview?.tag {
            selectedPizzaList[cellIndex] = selectedPizzaList[cellIndex].filter{$0.removeButton.tag != viewId}
            foodTable.reloadData()
            removeItem(viewId)
        }
    }
    
    func removeItem(_ orderItemIdToRemove: Int) {
        order.items = order.items.filter{$0.id != orderItemIdToRemove}
        //self.tabBarController?.tabBar.items![2].isEnabled = LocalRequest.checkOrder()
        tabBarController?.setTextAtributes()

    }
    
    @IBAction func goToCustomize(_ sender: StyleableButton) {
        
        sender.tintColor = .red
        
        if let destination = tabBarController?.viewControllers?[1] as? UINavigationController,
            let createYourOwn = destination.topViewController as? CreateYourOwnViewController {
                _ = createYourOwn.view
            
                let indexPath = IndexPath(row: sender.tag, section: 0)
                let cell = foodTable.cellForRow(at: indexPath) as! FoodTypeTableViewCell
            
                createYourOwn.usedIngredients = allIngredients.filter{allProducts[selectedRowIndex].ingredientIds.contains($0.id)}.map{($0, 0)}
                createYourOwn.selectedPizzaName.text = cell.foodNameLabel.text
                createYourOwn.selectedPizzaPrice.text = cell.foodPriceLabel.text
                createYourOwn.selectedPizzaPicture.image = cell.pizzaImage.image
                createYourOwn.selectedPizzaIngredients.text = cell.foodIngredientsLabel.text
                createYourOwn.selectedPizzaIndex = sender.tag
                createYourOwn.addButtonsForCrust()
                createYourOwn.addButtonsForSize()
                createYourOwn.setPizzaPrice()
            
                /* selects the same buttons (size and crust type) in the other controller*/
                setSameSize(in: createYourOwn, for: cell)
                setSameCrustType(in: createYourOwn, for: cell)
            
                createYourOwn.ingredientsTable.reloadData()
                tabBarController!.selectedIndex = 1
        }
       //sender.backgroundColor = MyColors.buttonDefaultBackgroundColor
    }
    
    func setSameCrustType(in destination: CreateYourOwnViewController, for cell: FoodTypeTableViewCell) {
        for subview in destination.crustTypeScrollView.subviews  {
            if let button = subview as? StyleableButton {
                if  button.tag == cell.getCrustType(){
                    if let destinationButton = (destination.crustTypeScrollView.subviews.filter{ $0.tag == cell.getCrustType()}[0]) as? StyleableButton {
                        destination.buttonIsSelected(destinationButton)
                        destination.crustTypeScrollView.contentOffset = cell.crustTypeScrollView.contentOffset
                    }
                }
            }
        }
        destination.setPizzaPrice()
    }
    
    func setSameSize(in destination: CreateYourOwnViewController, for cell: FoodTypeTableViewCell) {
        for subview in destination.pizzaSizeScrollView.subviews  {
            if let button = subview as? StyleableButton {
                if  button.tag == cell.getPizzaSize(){
                    if let destinationButton = (destination.pizzaSizeScrollView.subviews.filter{ $0.tag == cell.getPizzaSize()}[0]) as? StyleableButton {
                        destination.buttonIsSelected(destinationButton)
                        destination.pizzaSizeScrollView.contentOffset = cell.pizzaSizeScrollView.contentOffset
                    }
                }
            }
        }
        destination.setPizzaPrice()
    }
    
}
