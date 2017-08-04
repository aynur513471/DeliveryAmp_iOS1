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
    @IBOutlet weak var backButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegates()
        self.orderHistoryTable.contentInset = .zero
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func setDelegates() {
        orderHistoryTable.delegate = self
        orderHistoryTable.dataSource = self
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func checkTouch(_ sender: StyleableButton) {
        sender.isSelected = !sender.isSelected
    }
    
    @IBAction func goBack(_ sender: Any) {
        let _ = self.navigationController?.popViewController(animated: true)
    }
    

}
