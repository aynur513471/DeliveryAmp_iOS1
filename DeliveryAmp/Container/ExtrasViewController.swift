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
        selectedExtrasList = [[]]
        selectedExtrasList.reserveCapacity(allExtras.count)
        for _ in 0...allExtras.count {
            selectedExtrasList.append([])
        }
        self.tabBarController?.tabBar.items![2].isEnabled = LocalRequest.checkOrder()
        
        for item in order.items {
            if item.type == 2 {
                var view: SelectedExtrasType = .fromNib()
                view.descriptionLabel.text = item.product.name
                view.priceLabel.text = "$" + String(item.cost)
                view.removeButton.tag = item.id
                view.removeButton.addTarget(self, action: #selector(removeView), for: .touchUpInside)
                for (index, product) in allExtras.enumerated() {
                    if product.id == item.product.id {
                        selectedExtrasList[index].append(view)
                    }
                }
            }
            
        }
        
        extrasTable.reloadData()
    }
    
 
    
    func setDelegates() {
        self.extrasTable.delegate = self
        self.extrasTable.dataSource = self
    }
    
    
    // MARK: - Navigation
    
    @IBAction func addExtra(_ sender: UIButton) {
        
        let indexPath = IndexPath(row: sender.tag, section: 0)
        let myView: SelectedExtrasType = .fromNib()
        
        myView.tag = sender.tag
        myView.removeButton.tag = orderItemId //selectedExtrasList[(indexPath.row)].count
        myView.removeButton.addTarget(self, action: #selector(removeView), for: .touchUpInside)
            
        myView.descriptionLabel.text = getExtraDescription()
        myView.priceLabel.text = getExtraPrice()
            
        selectedExtrasList[(indexPath.row)].append(myView)
        extrasTable.reloadData()

        addToOrder(allExtras[sender.tag].id)
        
    }
    
    func addToOrder(_ productId: Int) {
        let newItem = OrderItem()
        newItem.type = 2
        newItem.id = orderItemId
        
        newItem.product = allExtras.filter{$0.id == productId}.map{product in OrderProduct(id: product.id, name: product.name, price: product.price)}[0]
        newItem.cost = Double(getExtraPrice().components(separatedBy: "$")[1])!
        
        orderItemId = OrderHelper.getNextOrderId()
        order.items.append(newItem)
        self.tabBarController?.tabBar.items![2].isEnabled = LocalRequest.checkOrder()
    }

    
    func removeView(sender: UIButton) {
        let viewId = sender.tag
        if let cellIndex = sender.superview?.tag {
            selectedExtrasList[cellIndex] = selectedExtrasList[cellIndex].filter{$0.removeButton.tag != viewId}
            extrasTable.reloadData()
            removeItem(viewId)
        }
    }
    
    func removeItem(_ orderItemIdToRemove: Int) {
        order.items = order.items.filter{$0.id != orderItemIdToRemove}
        self.tabBarController?.tabBar.items![2].isEnabled = LocalRequest.checkOrder()
    }
    
    
    
    

    

}
