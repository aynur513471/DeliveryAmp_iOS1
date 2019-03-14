//
//  ContainerViewController.swift
//  DeliveryAmp
//
//  Copyright © 2017 ThemeDimension.com
//

import UIKit

class ContainerViewController: UIViewController {
    
    // MARK: - Variables

    var foodViewController: FoodViewController!
    var beveragesViewController: BeveragesViewController!
    var extrasViewController: ExtrasViewController!
    
    var segueIdentifier : String!
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    func segueIdentifierReceivedFromParent(_ identifier: String){
        self.segueIdentifier = identifier
        self.performSegue(withIdentifier: self.segueIdentifier, sender: nil)
    }
    
    
    
    // MARK: - Navigation
    
    override open func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        emptyContainerView()
        
        if segue.identifier == "food" {
            foodViewController = segue.destination as? FoodViewController
            self.addChild(foodViewController)
            foodViewController.view.frame = CGRect(x: 0,y: 0, width: self.view.frame.width,height: self.view.frame.height)
            self.view.addSubview(foodViewController.view)
            foodViewController.didMove(toParent: self)
            
        } else if segue.identifier == "beverages" {
            beveragesViewController = segue.destination as? BeveragesViewController
            self.addChild(beveragesViewController)
            beveragesViewController.view.frame = CGRect(x: 0,y: 0, width: self.view.frame.width,height: self.view.frame.height)
            self.view.addSubview(beveragesViewController.view)
            beveragesViewController.didMove(toParent: self)
        } else if segue.identifier == "extras" {
            extrasViewController = segue.destination as? ExtrasViewController
            self.addChild(extrasViewController)
            extrasViewController.view.frame = CGRect(x: 0,y: 0, width: self.view.frame.width,height: self.view.frame.height)
            self.view.addSubview(extrasViewController.view)
            extrasViewController.didMove(toParent: self)
        }
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
