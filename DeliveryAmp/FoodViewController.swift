//
//  FoodViewController.swift
//  DeliveryAmp
//
//  Created by User on 8/1/17.
//
//

import UIKit

class FoodViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var foodTable: UITableView!
    
    // MARK: - Variables 
    
    var thereIsCellTapped = false
    var selectedRowIndex = -1

    var selectedPizzaList: [[SelectedPizzaType]] = [[]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDelegates()
        
        selectedPizzaList.reserveCapacity(10)
        for index in 0...10 {
            selectedPizzaList.append([])
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 
    func setDelegates() {
        self.foodTable.delegate = self
        self.foodTable.dataSource = self
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    var list = ["mama", "tata", "das", "dadsasada", "dsada"]
    @IBAction func addPizza(_ sender: UIButton) {
        
        let indexPath = IndexPath(row: sender.tag, section: 0)
        let cell = foodTable.cellForRow(at: indexPath) as! FoodTypeTableViewCell
        
        let myView: SelectedPizzaType = .fromNib()
        myView.tag = sender.tag //the view will have the same tag with the cell
        myView.removeButton.tag = selectedPizzaList[(indexPath.row)].count  //the tag represents the position of the view in vector
        myView.removeButton.addTarget(self, action: #selector(removeView), for: .touchUpInside)
        
        myView.descriptionLabel.text = list[myView.removeButton.tag]
        
        selectedPizzaList[(indexPath.row)].append(myView)
        foodTable.reloadData()

    }
    
    func removeView(sender: UIButton) {
        let index = sender.tag
        let cellIndex = sender.superview?.tag
        selectedPizzaList[(cellIndex)!].remove(at: index)
        foodTable.reloadData()
    }
    
}
