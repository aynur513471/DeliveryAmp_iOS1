//
//  CreateYourOwnViewController.swift
//  DeliveryAmp
//
//  Created by User on 7/27/17.
//
//

import UIKit

class CreateYourOwnViewController: UIViewController {

    
    //MARK - Outlets
    
    @IBOutlet weak var selectedPizzaPicture: UIImageView!
    @IBOutlet weak var selectedPizzaName: UILabel!
    @IBOutlet weak var selectedPizzaIngredients: UILabel!
    @IBOutlet weak var selectedPizzaPrice: UILabel!

    @IBOutlet weak var pizzaTypesTable: UITableView!
    @IBOutlet weak var ingredientsTable: UITableView!
    @IBOutlet weak var pizzaSizeScrollView: UIScrollView!
    @IBOutlet weak var crustTypeScrollView: UIScrollView!


    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDelegates()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Delegates
    
    func setDelegates() {
        ingredientsTable.delegate = self
        ingredientsTable.dataSource = self
        
        pizzaTypesTable.delegate = self
        pizzaTypesTable.dataSource = self
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func buttonPressed(_ sender: StyleableButton) {
        sender.isSelected = !sender.isSelected
        
    }

    @IBAction func selectPizzaSize(_ sender: StyleableButton) {
        deselectButtons(inside: pizzaSizeScrollView)
        sender.isSelected = !sender.isSelected
        
        
        /* here i will assign the size to my object*/
        switch sender.tag {
        case 0:
            //print("small")
            break
        case 1:
            //print("medium")
            break
        case 2:
           // print("large")
            break
        default:
            break
        }
    }

    
    @IBAction func selectCrustType(_ sender: UIButton) {
        deselectButtons(inside: crustTypeScrollView)
        sender.isSelected = !sender.isSelected
        
        /* here i will assign the crust type to my object*/
        switch sender.tag {
        case 0:
            //print("thin")
            break
        case 1:
           // print("thick")
            break
        default:
            break
        }
    }
    
    func deselectButtons(inside view: UIView) {
        for subview in view.subviews as [UIView] {
            if let btn = subview as? StyleableButton {
                btn.isSelected = false
            }
        }
    }

    @IBAction func changePizza(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            pizzaSizeScrollView.isHidden = true
            crustTypeScrollView.isHidden = true
            ingredientsTable.isHidden = true
            pizzaTypesTable.isHidden = false
           // pizzaTypesTable.reloadData()
        } else {
            pizzaSizeScrollView.isHidden = false
            crustTypeScrollView.isHidden = false
            ingredientsTable.isHidden = false
            pizzaTypesTable.isHidden = true
            
        }
    }
    
    @IBAction func resetIngredients(_ sender: StyleableButton) {
        ingredientsTable.reloadData()
    }
    


}
