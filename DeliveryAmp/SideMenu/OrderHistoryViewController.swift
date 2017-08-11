//
//  CheckoutViewController.swift
//  DeliveryAmp
//
//  Created by User on 7/28/17.
//
//

import UIKit

class OrderHistoryViewController: UIViewController {

    @IBOutlet weak var orderHistoryTable: UITableView!
    
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

    
    
    // MARK: - Navigation

    @IBAction func checkTouch(_ sender: StyleableButton) {
        sender.isSelected = !sender.isSelected
    }
    
    @IBAction func goBack(_ sender: Any) {
        let _ = self.navigationController?.popViewController(animated: true)
        self.tabBarController?.tabBar.isHidden = false
    }
    

}
