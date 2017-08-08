//
//  MenuViewController.swift
//  DeliveryAmp
//
//  Created by User on 8/1/17.
//
//

import UIKit


//!!!!CHANGE this to false when adding serverside



class MenuViewController: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var foodButton: UIButton!
    @IBOutlet weak var beveragesButton: UIButton!
    @IBOutlet weak var extrasButton: UIButton!
    
    var container: ContainerViewController!
    
    // MARK: - Variables
    
    /*
    var allProducts: [Product] = []
    var servingSizesBeverages: [ServingSize] = []
    var servingSizesFood: [ServingSize] = []
    var allProductTypes: [ProductType] = []
    var allIngredients: [Ingredient] = []
    */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        selectFood(foodButton)
        // Do any additional setup after loading the view.
    }
    

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.view.addDiagonalGradient(self.view, [MyColors.darkBlue.cgColor, MyColors.lightBlue.cgColor], self.view.frame)
        self.view.layoutIfNeeded()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    func deselectButtons(inside view: UIView) {
        for subview in view.subviews as [UIView] {
            if let btn = subview as? StyleableButton {
                btn.isSelected = false
            }
        }
    }
    
    @IBAction func selectFood(_ sender: UIButton) {
        sender.isSelected = true
        beveragesButton.isSelected = false
        extrasButton.isSelected = false
        container!.segueIdentifierReceivedFromParent("food")
    }
    
    @IBAction func selectBeverages(_ sender: UIButton) {
        sender.isSelected = true
        foodButton.isSelected = false
        extrasButton.isSelected = false
        container!.segueIdentifierReceivedFromParent("beverages")
    }
    
    @IBAction func selectExtras(_ sender: UIButton) {
        sender.isSelected = true
        beveragesButton.isSelected = false
        foodButton.isSelected = false
        container!.segueIdentifierReceivedFromParent("extras")
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "container"{
            container = segue.destination as! ContainerViewController
            
            /*
            container!.allProducts = self.allProducts
            container!.allIngredients = self.allIngredients
            container!.allProductTypes = self.allProductTypes
            container!.servingSizesFood = self.servingSizesFood
            container!.servingSizesBeverages = self.servingSizesBeverages
*/
        }
    }
}
