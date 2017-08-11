//
//  ExtrasViewController.swift
//  DeliveryAmp
//
//  Created by User on 8/1/17.
//
//

import UIKit

class ExtrasViewController: UIViewController {

    // MARK: - Variables
    
    @IBOutlet weak var extrasTable: UITableView!

    
    //var thereIsCellTapped = false
    var selectedRowIndex = -1
    
    var selectedExtrasList: [[SelectedExtrasType]] = [[]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDelegates()
                
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        selectedExtrasList.reserveCapacity(allExtras.count)
        for _ in 0...allExtras.count {
            selectedExtrasList.append([])
        }
        
    }
    
 
    
    func setDelegates() {
        self.extrasTable.delegate = self
        self.extrasTable.dataSource = self
    }
    
    
    // MARK: - Navigation
    
    @IBAction func addExtra(_ sender: UIButton) {
        
        let indexPath = IndexPath(row: sender.tag, section: 0)
        let myView: SelectedExtrasType = .fromNib()
        //let cell = extrasTable.cellForRow(at: indexPath) as! ExtrasTypeTableViewCell
     
        myView.tag = sender.tag
        myView.removeButton.tag = selectedExtrasList[(indexPath.row)].count
        myView.removeButton.addTarget(self, action: #selector(removeView), for: .touchUpInside)
            
        myView.descriptionLabel.text = getExtraDescription()
        myView.priceLabel.text = getExtraPrice()
            
        selectedExtrasList[(indexPath.row)].append(myView)
        extrasTable.reloadData()
      
        
    }
    
    func removeView(sender: UIButton) {
        let index = sender.tag
        let cellIndex = sender.superview?.tag
        selectedExtrasList[(cellIndex)!].remove(at: index)
        extrasTable.reloadData()
    }
    
    
    
    
    

    

}
