//
//  MenuViewController.swift
//  DeliveryAmp
//
//  Created by User on 8/1/17.
//
//

import UIKit


class MenuViewController: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var foodButton: UIButton!
    @IBOutlet weak var beveragesButton: UIButton!
    @IBOutlet weak var extrasButton: UIButton!
    
    var container: ContainerViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectFood(foodButton)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
        self.view.addDiagonalGradient(self.view, [MyColors.darkBlue.cgColor, MyColors.lightBlue.cgColor], self.view.frame)
        self.view.layoutIfNeeded()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    // MARK: - Navigation

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

        }
    }
}
