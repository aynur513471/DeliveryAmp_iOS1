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

    
    @IBAction func addItemToOrder(_ sender: StyleableButton) {
        order = orderHistory[sender.tag]
        let _ = self.navigationController?.popViewController(animated: true)
        self.tabBarController?.tabBar.isHidden = false
        self.tabBarController?.selectedIndex = 2
    }
    
    
    
    // MARK: - Navigation
    
    @IBAction func goBack(_ sender: Any) {
        let _ = self.navigationController?.popViewController(animated: true)
        self.tabBarController?.tabBar.isHidden = false
    }
    

}
