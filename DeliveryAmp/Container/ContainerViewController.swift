//
//  ContainerViewController.swift
//  DeliveryAmp
//
//  Created by User on 8/1/17.
//
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
            foodViewController = segue.destination as! FoodViewController
            self.addChildViewController(foodViewController)
            foodViewController.view.frame = CGRect(x: 0,y: 0, width: self.view.frame.width,height: self.view.frame.height)
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