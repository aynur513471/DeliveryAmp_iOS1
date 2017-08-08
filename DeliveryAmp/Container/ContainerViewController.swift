//
//  ContainerViewController.swift
//  DeliveryAmp
//
//  Created by User on 8/1/17.
//
//

import UIKit

class ContainerViewController: UIViewController {
    
    var viewController : UIViewController!

    var foodViewController: FoodViewController!
    var beveragesViewController: BeveragesViewController!
    var extrasViewController: ExtrasViewController!
    
    var segueIdentifier : String!
    
    var allProducts: [Product]!
    var servingSizesBeverages: [ServingSize]!
    var servingSizesFood: [ServingSize]!
    var allProductTypes: [ProductType]!
    var allIngredients: [Ingredient]!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func segueIdentifierReceivedFromParent(_ identifier: String){
        self.segueIdentifier = identifier
        self.performSegue(withIdentifier: self.segueIdentifier, sender: nil)
    }
    
    
    override open func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        emptyContainerView()
        
        if segue.identifier == "food" {
            foodViewController = segue.destination as! FoodViewController
            self.addChildViewController(foodViewController)
            foodViewController.view.frame = CGRect(x: 0,y: 0, width: self.view.frame.width,height: self.view.frame.height)
            foodViewController.allProducts = self.allProducts
            foodViewController.servingSizesFood = self.servingSizesFood
            foodViewController.allProductTypes = self.allProductTypes
            foodViewController.allIngredients = self.allIngredients
            
            self.view.addSubview(foodViewController.view)
            foodViewController.didMove(toParentViewController: self)
            
        } else if segue.identifier == "beverages" {
            beveragesViewController = segue.destination as! BeveragesViewController
            self.addChildViewController(beveragesViewController)
            beveragesViewController.view.frame = CGRect(x: 0,y: 0, width: self.view.frame.width,height: self.view.frame.height)
            self.view.addSubview(beveragesViewController.view)
            beveragesViewController.didMove(toParentViewController: self)
        } else if segue.identifier == "extras" {
            extrasViewController = segue.destination as! ExtrasViewController
            self.addChildViewController(extrasViewController)
            extrasViewController.view.frame = CGRect(x: 0,y: 0, width: self.view.frame.width,height: self.view.frame.height)
            self.view.addSubview(extrasViewController.view)
            extrasViewController.didMove(toParentViewController: self)
        }
        
        /*
        if segue.identifier == segueIdentifier{
            
            //Remove Container View
            if viewController != nil{
                viewController.view.removeFromSuperview()
                viewController = nil
            }

            viewController = segue.destination
            self.addChildViewController(viewController)
            viewController.view.frame = CGRect(x: 0,y: 0, width: self.view.frame.width,height: self.view.frame.height)
            self.view.addSubview(viewController.view)
            viewController.didMove(toParentViewController: self)
        }
        */
    }
    
    func emptyContainerView() {
     
        if foodViewController != nil{
            foodViewController.view.removeFromSuperview()
            foodViewController = nil
        }
        
        if beveragesViewController != nil{
            beveragesViewController.view.removeFromSuperview()
            beveragesViewController = nil
        }
        
        if extrasViewController != nil{
            extrasViewController.view.removeFromSuperview()
            extrasViewController = nil
        }
    }

}
