//
//  CheckoutViewController.swift
//  DeliveryAmp
//
//  Created by User on 7/28/17.
//
//

import UIKit

class OrderHistoryViewController: UIViewController {

    //MARK: - Outlets 
    
    @IBOutlet weak var orderHistoryTable: UITableView!
    
    //MARK: - Variables
    
    var selectedRowIndex: Int = -1
    var selectedAsNew: [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDelegates()
        self.orderHistoryTable.contentInset = .zero
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        
        self.view.addDiagonalGradient(self.view, [MyColors.darkBlue.cgColor, MyColors.lightBlue.cgColor], self.view.frame)
        self.view.layoutIfNeeded()
    }
    
    func setDelegates() {
        orderHistoryTable.delegate = self
        orderHistoryTable.dataSource = self
    }

    
    @IBAction func addAsNew(_ sender: StyleableButton) {
        order = orderHistory[sender.tag]
        CurrentUser.sharedInstance.firstName = order.firstName
        CurrentUser.sharedInstance.lastName = order.lastName
        CurrentUser.sharedInstance.address = order.address
        CurrentUser.sharedInstance.phone = order.phone
        CurrentUser.sharedInstance.email = order.email
        let _ = self.navigationController?.popViewController(animated: true)
        self.tabBarController?.tabBar.isHidden = false
        self.tabBarController?.selectedIndex = 2
    }
    

    @IBAction func deleteHistory(_ sender: Any) {
        let deleteHistoryAlert = UIAlertController(title: "Delete All?", message: "This action will clear all your order history.", preferredStyle: UIAlertControllerStyle.alert)
        
        deleteHistoryAlert.addAction(UIAlertAction(title: "Delete", style: .default, handler: { (action: UIAlertAction!) in
            orderHistory = []
            LocalRequest.postJSON(json: ["orders": []], path: "order_history") {
                (result, error) in
                if error{
                    print("Could not delete order history!")
                }
            }
            self.orderHistoryTable.reloadData()
        }))
        
        deleteHistoryAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(deleteHistoryAlert, animated: true, completion: nil)
    }
    
    
    // MARK: - Navigation
    
    @IBAction func goBack(_ sender: Any) {
        let _ = self.navigationController?.popViewController(animated: true)
        self.tabBarController?.tabBar.isHidden = false
    }
    

}
