//
//  LaunchViewController.swift
//  DeliveryAmp
//
//  Created by User on 8/4/17.
//
//

import Foundation
import UIKit
import SideMenu

class LaunchViewController: UIViewController {
    
    // MARK: - Variables
    
    var allProducts: [Product] = []
    var allBeverages: [Beverage] = []
    var allExtras: [Extra] = []
    var servingSizesBeverages: [ServingSize] = []
    var servingSizesFood: [ServingSize] = []
    var allProductTypes: [ProductType] = []
    var allIngredients: [Ingredient] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        readData()
        goToMainScreen()
        
        SideMenuManager.menuPresentMode = .menuSlideIn
        SideMenuManager.menuFadeStatusBar = false
        
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: MyColors.myBlack], for: .selected)
    }
    
    
    func readData() {
        getProducts()
        getBeverages()
        getExtras()
        getServingSizesBeverages()
        getServingSizesFood()
        getProductTypes()
        getIngredients()
    }
    
    func getProductTypes(){
        
        LocalRequest.getProductTypes({
            (productTypesOptional: [ProductType]?, error: String?) -> Void in
            if let _ = error{
                Alert.showDefaultAlert(for: self, title: nil, message: error)
            }else if let productTypes = productTypesOptional {
                self.allProductTypes = productTypes
            }
        })
        
    }
    
    func getServingSizesBeverages(){
        
        LocalRequest.getServingSizesBeverages({
            (servingSizesOptional: [ServingSize]?, error: String?) -> Void in
            if let _ = error{
                Alert.showDefaultAlert(for: self, title: nil, message: error)
            }else if let servingSizes = servingSizesOptional {
                self.servingSizesBeverages = servingSizes
            }
        })
        
    }
    
    func getServingSizesFood(){
        
        LocalRequest.getServingSizesFood({
            (servingSizesOptional: [ServingSize]?, error: String?) -> Void in
            if let _ = error{
                Alert.showDefaultAlert(for: self, title: nil, message: error)
            }else if let servingSizes = servingSizesOptional {
                self.servingSizesFood = servingSizes
            }
        })
        
    }
    
    func getProducts(){
        
        LocalRequest.getProducts({
            (productsOptional: [Product]?, error: String?) -> Void in
            if let _ = error{
                Alert.showDefaultAlert(for: self, title: nil, message: error)
            }else if let products = productsOptional {
                self.allProducts = products
            }
        })
        
    }
    
    func getIngredients(){
        
        LocalRequest.getIngredients({
            (ingredientsOptional: [Ingredient]?, error: String?) -> Void in
            if let _ = error{
                Alert.showDefaultAlert(for: self, title: nil, message: error)
            }else if let ingredients = ingredientsOptional {
                self.allIngredients = ingredients
            }
        })
        
    }
    
    func getBeverages(){
        
        LocalRequest.getBeverages({
            (beveragesOptional: [Beverage]?, error: String?) -> Void in
            if let _ = error{
                Alert.showDefaultAlert(for: self, title: nil, message: error)
            }else if let beverages = beveragesOptional {
                self.allBeverages = beverages
            }
        })
        
    }
    
    func getExtras(){
        
        LocalRequest.getExtras({
            (extrasOptional: [Extra]?, error: String?) -> Void in
            if let _ = error{
                Alert.showDefaultAlert(for: self, title: nil, message: error)
            }else if let extras = extrasOptional {
                self.allExtras = extras
            }
        })
        
    }

    
    func goToMainScreen(){
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "main", sender: self)
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let myTabBarController = segue.destination as!  UITabBarController
        
        var navController = myTabBarController.viewControllers![0] as! UINavigationController
        let menuViewController = navController.topViewController as! MenuViewController
        menuViewController.allProducts = self.allProducts
        menuViewController.servingSizesBeverages = self.servingSizesBeverages
        menuViewController.servingSizesFood = self.servingSizesFood
        menuViewController.allProductTypes = self.allProductTypes
        menuViewController.allIngredients = self.allIngredients
        
        navController = myTabBarController.viewControllers![1] as! UINavigationController
        let createYourOwnViewController = navController.topViewController as! CreateYourOwnViewController
         _ = createYourOwnViewController.view
        
        createYourOwnViewController.allProducts = self.allProducts
        createYourOwnViewController.servingSizesFood = self.servingSizesFood
        createYourOwnViewController.allProductTypes = self.allProductTypes
        createYourOwnViewController.allIngredients = self.allIngredients
        
       
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
