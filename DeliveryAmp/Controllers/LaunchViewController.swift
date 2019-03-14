//
//  LaunchViewController.swift
//  DeliveryAmp
//
//  Copyright © 2017 ThemeDimension.com
//

import Foundation
import UIKit
import SideMenu

// Global variables for entire project

var allProducts: [Product] = []
var allBeverages: [Beverage] = []
var allExtras: [Extra] = []
var servingSizesBeverages: [ServingSize] = []
var servingSizesFood: [ServingSize] = []
var allProductTypes: [ProductType] = []
var allIngredients: [Ingredient] = []
var orderHistory: [Order] = []
var orderItemId = 0
var order = Order()




class LaunchViewController: UIViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        getUser()
        
        
        SideMenuManager.default.menuPresentMode = .menuSlideIn
        SideMenuManager.default.menuFadeStatusBar = false
        
        
        UITabBarItem.appearance().setTitleTextAttributes(convertToOptionalNSAttributedStringKeyDictionary([convertFromNSAttributedStringKey(NSAttributedString.Key.foregroundColor): MyColors.myBlack]), for: .selected)
        
      
        
    }
    
    
    func getUser() {

        LocalRequest.getUser({
            (userOptional: User?, error: String?) -> Void in
            if let _ = error{
                self.getProducts()
                Alert.showDefaultAlert(for: self, title: nil, message: error)
            }else if let savedUser = userOptional {
                CurrentUser.sharedInstance.copy(savedUser)
                self.getProducts()
            }
        })
    }
    
    func getProducts(){
        
        LocalRequest.getProducts({
            (productsOptional: [Product]?, error: String?) -> Void in
            if let _ = error{
                Alert.showDefaultAlert(for: self, title: nil, message: error)
            }else if let products = productsOptional {
                allProducts = products
                self.getBeverages()
            }
        })
        
    }
    
    func getBeverages(){
        
        LocalRequest.getBeverages({
            (beveragesOptional: [Beverage]?, error: String?) -> Void in
            if let _ = error{
                Alert.showDefaultAlert(for: self, title: nil, message: error)
            }else if let beverages = beveragesOptional {
                allBeverages = beverages
                self.getExtras()
            }
        })
    }
    
    func getExtras(){
        
        LocalRequest.getExtras({
            (extrasOptional: [Extra]?, error: String?) -> Void in
            if let _ = error{
                Alert.showDefaultAlert(for: self, title: nil, message: error)
            }else if let extras = extrasOptional {
                allExtras = extras
                self.getServingSizesBeverages()
            }
        })
    }
    
    
    func getServingSizesBeverages(){
        
        LocalRequest.getServingSizesBeverages({
            (servingSizesOptional: [ServingSize]?, error: String?) -> Void in
            if let _ = error{
                Alert.showDefaultAlert(for: self, title: nil, message: error)
            }else if let servingSizes = servingSizesOptional {
                servingSizesBeverages = servingSizes
                self.getServingSizesFood()
            }
        })
        
    }
    
    func getServingSizesFood(){
        
        LocalRequest.getServingSizesFood({
            (servingSizesOptional: [ServingSize]?, error: String?) -> Void in
            if let _ = error{
                Alert.showDefaultAlert(for: self, title: nil, message: error)
            }else if let servingSizes = servingSizesOptional {
                servingSizesFood = servingSizes
                self.getProductTypes()
            }
        })
        
    }
    
    func getProductTypes(){
        
        LocalRequest.getProductTypes({
            (productTypesOptional: [ProductType]?, error: String?) -> Void in
            if let _ = error{
                Alert.showDefaultAlert(for: self, title: nil, message: error)
            }else if let productTypes = productTypesOptional {
                allProductTypes = productTypes
                self.getIngredients()
            }
        })
        
    }
    
    
    func getIngredients(){
        
        LocalRequest.getIngredients({
            (ingredientsOptional: [Ingredient]?, error: String?) -> Void in
            if let _ = error{
                Alert.showDefaultAlert(for: self, title: nil, message: error)
            }else if let ingredients = ingredientsOptional {
                allIngredients = ingredients
                self.getOrderHistory()
            }
        })
        
    }
    
    func getOrderHistory() {
        LocalRequest.getOrderHistory({
            (orderHistoryOptional: [Order]?, error: String?) -> Void in
            if let _ = error{
                //Alert.showDefaultAlert(for: self, title: nil, message: error)
                self.goToMainScreen()
            }else if let orderHistoryTemp = orderHistoryOptional {
                orderHistory = orderHistoryTemp
                self.goToMainScreen()
            }
        })
    }
    
    
    func goToMainScreen(){
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "main", sender: self)
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if let myTabBarController = segue.destination as?  UITabBarController {
            if let navController = myTabBarController.viewControllers![1] as? UINavigationController,
                let createYourOwnViewController = navController.topViewController as? CreateYourOwnViewController {
                
                _ = createYourOwnViewController.view

                createYourOwnViewController.usedIngredients = allIngredients.filter{allProducts[0].ingredientIds.contains($0.id)}.map{($0, 0)}
                createYourOwnViewController.selectedPizzaName.text = allProducts[0].name        
                if let url = URL(string:  allProducts[0].imageUrl){
                    createYourOwnViewController.selectedPizzaPicture.sd_setImage(
                        with: url,
                        placeholderImage: UIImage(named: "menu_icon.png"),
                        options: [.continueInBackground, .progressiveDownload]
                    )
                }else{
                    //cell.pizzaImage.image =
                }
                createYourOwnViewController.selectedPizzaIngredients.text = allProducts[0].productDescription
                createYourOwnViewController.ingredientsTable.reloadData()
                createYourOwnViewController.addButtonsForCrust()
                createYourOwnViewController.addButtonsForSize()
                createYourOwnViewController.setPizzaPrice()
            }
        }
    }

}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertToOptionalNSAttributedStringKeyDictionary(_ input: [String: Any]?) -> [NSAttributedString.Key: Any]? {
	guard let input = input else { return nil }
	return Dictionary(uniqueKeysWithValues: input.map { key, value in (NSAttributedString.Key(rawValue: key), value)})
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromNSAttributedStringKey(_ input: NSAttributedString.Key) -> String {
	return input.rawValue
}
