//
//  CheckoutViewController.swift
//  DeliveryAmp
//
//  Created by User on 8/4/17.
//

import UIKit
import Foundation
import SideMenu


class CheckoutViewController: UIViewController, UITextFieldDelegate, UIScrollViewDelegate {
    
    
    
    
    //MARK: Outlets
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var viewWithShadow: ViewWithShadow!
    @IBOutlet weak var paymentView: UIView!
    @IBOutlet weak var checkbox1: UIButton!
    @IBOutlet weak var checkbox2: UIButton!
    
    
    //order view
    @IBOutlet weak var totalLabel: UILabel!
    
    @IBOutlet weak var orderView: UIView!
    @IBOutlet weak var orderViewHeight: NSLayoutConstraint!
    
    var orderList : [[SelectedPizzaType]] = []
    
    //delivery
    @IBOutlet weak var firstNameTextField: StyleableTextFieldWithPadding!
    @IBOutlet weak var lastNameTextField: StyleableTextFieldWithPadding!
    @IBOutlet weak var phoneNumberTextField: StyleableTextFieldWithPadding!
    @IBOutlet weak var emailTextField: StyleableTextFieldWithPadding!
    @IBOutlet weak var addressTextField: StyleableTextFieldWithPadding!
    
    @IBOutlet weak var saveDeliveryLabel: UILabel!
    //payment
    @IBOutlet weak var payControl: UISegmentedControl!
    
    @IBOutlet weak var cardNumberTextField: StyleableTextFieldWithPadding!
    @IBOutlet weak var expDateTextField: StyleableTextFieldWithPadding!
    @IBOutlet weak var csvTextField: StyleableTextFieldWithPadding!
    @IBOutlet weak var holderNameTextField: StyleableTextFieldWithPadding!
    
    @IBOutlet weak var payViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var dismissBtn: StyleableButton!
    @IBOutlet weak var placeOrderBtn: StyleableButton!
    @IBOutlet weak var savePayLabel: UILabel!
    
    //MARK: Variables
    var datePicker: UIPickerView = UIPickerView()
    var activeFieldRect : CGRect!
    var flag1 = 0
    var flag2 = 0
    var total:Double = 0
    
    var foodView:[SelectedPizzaType?]  = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDelegates()
        hideKeyboardWhenTappedAround()
        
        addTapToCheckboxes()
 
        let sortedViews = payControl.subviews.sorted( by: { $0.frame.origin.x < $1.frame.origin.x } )
        sortedViews[0].tintColor = MyColors.segmentedControl //seg
        
        self.expDateTextField.inputView = self.datePicker
       
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.addKeyboardObservers()
        tabBarController?.tabBar.isHidden = false
        orderViewHeight.constant = 0
        
        payControl.customizeSegmentedControl()
        payControl.changeTitleFont(newFontName: "Roboto-Medium", newFontSize: 9.0)
        
        if CurrentUser.sharedInstance.exists {
            setDeliverytextFields()
            
        }
        if CurrentUser.sharedInstance.creditCard.isCompleted() {
            setPaymentFields()
        }
        //SideMenuManager.menuAddScreenEdgePanGesturesToPresent(toView: view)
        
        
        

    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.scrollView.contentInset = .zero
        configureOrder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeKeyboardObservers()
        removeSubviews()
    }
    
   
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Configurations
    func addTapToCheckboxes() {
        let tap1:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(CheckoutViewController.checkbox_TouchUpInside(_:)))
        tap1.cancelsTouchesInView = false
        saveDeliveryLabel.addGestureRecognizer(tap1)
        let tap2:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(CheckoutViewController.checkboxSavePay_touchUpInside(_:)))
        tap2.cancelsTouchesInView  = false
        savePayLabel.addGestureRecognizer(tap2)
        self.view.translatesAutoresizingMaskIntoConstraints = true

    
    }
    func setDeliverytextFields(){
        firstNameTextField.text = CurrentUser.sharedInstance.firstName
        lastNameTextField.text = CurrentUser.sharedInstance.lastName
        phoneNumberTextField.text = CurrentUser.sharedInstance.phone
        emailTextField.text = CurrentUser.sharedInstance.email
        addressTextField.text = CurrentUser.sharedInstance.address
        
    }
    func setPaymentFields(){
        cardNumberTextField.text = formatCardNumber(cardNumber: CurrentUser.sharedInstance.creditCard.cardNumber)
        expDateTextField.text = "\(CurrentUser.sharedInstance.creditCard.expMonth)/\(CurrentUser.sharedInstance.creditCard.expYear)"
        csvTextField.text = "\(CurrentUser.sharedInstance.creditCard.csvCode)"
        holderNameTextField.text = CurrentUser.sharedInstance.creditCard.cardHolder
    }
    
    
    //MARK : Delegates
    func setDelegates(){
        
        
        firstNameTextField.delegate = self
        lastNameTextField.delegate = self
        phoneNumberTextField.delegate = self
        emailTextField.delegate = self
        addressTextField.delegate = self
        
        cardNumberTextField.delegate = self
        expDateTextField.delegate = self
        csvTextField.delegate = self
        holderNameTextField.delegate = self
        
        datePicker.delegate = self
        datePicker.dataSource = self
        
        scrollView.delegate = self
        
    }


    
 
    
    //MARK: Actions
    
    
    //Segmened Control
    @IBAction func PayButton(_ sender: Any) {
        
        let sortedViews = (sender as AnyObject).subviews.sorted( by: { $0.frame.origin.x < $1.frame.origin.x } )
        
        for (index, view) in sortedViews.enumerated() {
            if index == (sender as AnyObject).selectedSegmentIndex {
                view.tintColor = MyColors.segmentedControl //seg
                
                if(payControl.selectedSegmentIndex == 0)
                {
                    paymentView.isHidden = false
                    payViewHeight.constant = 112
                    dismissBtn.isHidden = false
                    placeOrderBtn.isHidden = false
                    
                }
                else if(payControl.selectedSegmentIndex == 1)
                {
                    paymentView.isHidden = true
                    payViewHeight.constant = 0
                    dismissBtn.isHidden = true
                    placeOrderBtn.isHidden = true
                    if checkFields()
                    {
                        performSegue(withIdentifier: "toPayPal", sender: sender)
                       
                    }
                    else{
                        view.tintColor = MyColors.buttonTextColor
                        payControl.selectedSegmentIndex = UISegmentedControlNoSegment
                    }
                }
                else if(payControl.selectedSegmentIndex == 2){
                    paymentView.isHidden = true
                    payViewHeight.constant = 0
                    dismissBtn.isHidden = false
                    placeOrderBtn.isHidden = false
                    
                }
                
            } else {
                view.tintColor = MyColors.buttonTextColor
            }
        }
    }
    
    //CheckBoxes
    @IBAction func checkboxSavePay_touchUpInside(_ sender: Any) {
        if flag2 == 0
        {
            self.checkbox2.setImage(#imageLiteral(resourceName: "Checked Checkbox"), for: .normal)
            flag2 = 1
        }
        else
        {
            self.checkbox2.setImage(#imageLiteral(resourceName: "Unchecked Checkbox"), for: .normal)
            flag2 = 0
        }
    }
    @IBAction func checkbox_TouchUpInside(_ sender: Any) {
        if flag1 == 0
        {
            self.checkbox1.setImage(#imageLiteral(resourceName: "Checked Checkbox"), for: .normal)
            flag1 = 1
        }
        else
        {
            self.checkbox1.setImage(#imageLiteral(resourceName: "Unchecked Checkbox"), for: .normal)
            flag1 = 0
        }
    }
    
    //dismiss Order
    @IBAction func dismissOrder_TouchUpInside(_ sender: Any) {
        let alert = UIAlertController(title: "Dismiss Order?", message: "This action will remove all the selected products.", preferredStyle: .alert)
        let agreeAction = UIAlertAction(title: "Agree", style: .default) { (alert: UIAlertAction!) -> Void in
            order.items = []
            self.configureOrder()
            
            self.tabBarController?.selectedIndex = 0
            
        }
        let disagreeAction = UIAlertAction(title: "Disagree", style: .cancel) { (alert: UIAlertAction!) -> Void in
            //print("You pressed Cancel")
        }
        
        alert.addAction(agreeAction)
        alert.addAction(disagreeAction)
        
        present(alert, animated: true, completion:nil)
        
    }
    //Place Order Button
    @IBAction func placeOrder_TouchUpInside(_ sender: Any) {
        
        if  order.items.count > 0 {
            if checkFields() {
                order.date = getCurrentDate()
                order.firstName = firstNameTextField.text!
                order.lastName = lastNameTextField.text!
                order.phone = phoneNumberTextField.text!
                order.email = emailTextField.text!
                order.address = addressTextField.text!
                order.totalCost = Double(totalLabel.text!.components(separatedBy: Constants.currency)[1])!
            //load data in my object
            if flag1 == 1{
                //save my delivery Options
                CurrentUser.sharedInstance.firstName = firstNameTextField.text!
                CurrentUser.sharedInstance.lastName = lastNameTextField.text!
                CurrentUser.sharedInstance.phone = phoneNumberTextField.text!
                CurrentUser.sharedInstance.email = emailTextField.text!
                CurrentUser.sharedInstance.address = addressTextField.text!
                LocalRequest.updateUser(user: CurrentUser.sharedInstance, { (error) in
                    print(error!)
                })
            }
            
            if payControl.selectedSegmentIndex == 0 {
                if !emptyCreditCardFields() &&  checkCreditCardFields() {
                    if flag2 == 1 {
                        //save payment options
                        var strings = expDateTextField.text?.components(separatedBy: "/")
                        
                        
                        CurrentUser.sharedInstance.creditCard.cardNumber = ""
                        for component in cardNumberTextField.text!.components(separatedBy: "-") {
                            CurrentUser.sharedInstance.creditCard.cardNumber += component
                        }
                        
                        
                        
                        CurrentUser.sharedInstance.creditCard.expMonth = Int((strings?[0])!)!
                        CurrentUser.sharedInstance.creditCard.expYear = Int((strings?[1])!)!
                        CurrentUser.sharedInstance.creditCard.csvCode = Int(csvTextField.text!)!
                        CurrentUser.sharedInstance.creditCard.cardHolder = holderNameTextField.text!
                        LocalRequest.updateUser(user: CurrentUser.sharedInstance, { (error) in
                            print(error!)
                        })
                    }
                    completeOrder()
                }
            } else if payControl.selectedSegmentIndex == 2 {
                completeOrder()
            }
            
            
          
            
            }
        }else {
            let alert = UIAlertController(title: nil , message: "No items selected.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
               
                
                self.tabBarController?.selectedIndex = 0
            }))
            present(alert,animated: true,completion: nil)
            
        }
    }
    
    func completeOrder() {
        order.totalCost = Double(totalLabel.text!.components(separatedBy: Constants.currency)[1])!
         let newOrder : Order = Order(date: order.date , address: order.address, deliveryDetailsHadChanged: order.deliveryDetailsHadChanged, email: order.email, firstName: order.firstName, lastName: order.lastName, phone: order.phone, totalCost: order.totalCost, orderHasItems: order.orderHasItems, items: order.items)
        
        let placeOrderAlert = UIAlertController(title: "Place Order?", message: "If you agree, your order will be sent.", preferredStyle: UIAlertControllerStyle.alert)
        
        placeOrderAlert.addAction(UIAlertAction(title: "Agree", style: .default, handler: { (action: UIAlertAction!) in
            
            LocalRequest.postOrderToOrderHistory(order: newOrder, { (error) in
                if error != nil {
                 Alert.showDefaultAlert(for: self, title: nil, message: "Order could not be placed!")
                }else{
                    Alert.showDefaultAlert(for: self, title: nil, message: "Order placed!")

                }
            })
            
            order.items = []
            self.tabBarController?.selectedIndex = 0

        }))
        
        placeOrderAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(placeOrderAlert, animated: true, completion: nil)
        
    }
    

    //MARK: Order View Configuration
    func configureOrder(){
        removeSubviews()
        
        let nrItems = order.items.count
        foodView  = [SelectedPizzaType?](repeating: nil,count : nrItems)
        total = 0
        totalLabel.text = Constants.currency + "\(total)"
        
        var foodName : String
        var foodPrice : Double
        
        let height:CGFloat = 35
        var y:CGFloat = 0
        
        orderView.translatesAutoresizingMaskIntoConstraints = false
        
        if nrItems >= 0{
            for i in 0..<order.items.count{
                
                let item = order.items[i]
                
                switch item.type{
                case 0 :
                    //pizza
                    if item.ingredients.count <= 0 {
                        self.orderViewHeight.constant += height
                        foodView[i] = .fromNib()
                        foodView[i]?.tag = item.id
                        foodView[i]?.removeButton.tag = item.id
                        foodView[i]?.removeButton.addTarget(self, action: #selector(removeView), for: .touchUpInside)
                        
                        foodName = "\(item.product.name) \(item.productType.name) + \(item.servingSize.name)"
                        foodPrice = item.cost
                        foodView[i]?.descriptionLabel.text = foodName
                        foodView[i]?.priceLabel.text = "$\(foodPrice)"
                        total += foodPrice
                        
                        orderView.addSubview(foodView[i]!)
                        foodView[i]?.frame = CGRect(x: 0, y:y, width: orderView.frame.width, height: height)
                        
                        y = y + height
                    } else {
                        self.orderViewHeight.constant += height + 10
                        foodView[i] = .fromNib()
                        
                        foodView[i]?.tag = item.id
                        foodView[i]?.removeButton.tag = item.id
                        
                        foodView[i]?.removeButton.addTarget(self, action: #selector(removeView), for: .touchUpInside)
                        foodName = "(C) \(item.product.name) \(item.productType.name) + \(item.servingSize.name)"
                        foodPrice = item.cost
                        
                        foodView[i]?.descriptionLabel.text = foodName
                        foodView[i]?.priceLabel.text = "$\(foodPrice)"
                        total += foodPrice
                        
                        orderView.addSubview(foodView[i]!)
                        foodView[i]?.frame = CGRect(x: 0, y:y, width: orderView.frame.width, height: height)
                        
                        var j :CGFloat = 35
                        for ingredient in item.ingredients {
                            
                            self.orderViewHeight.constant += height
                            let ingredientView:SelectedPizzaType = .fromNib()
                            ingredientView.isSubview = true
                            ingredientView.descriptionLabel.text = "\(Int(ingredient.quantity)) x \(ingredient.name)"
                            ingredientView.descriptionLabel.textColor = MyColors.myBlack
                            ingredientView.priceLabel.text = "$\(ingredient.cost)"
                            ingredientView.priceLabel.textColor = MyColors.myBlack
                            ingredientView.removeButtonWidthConstraint.constant = 0
                            ingredientView.backgroundColor = MyColors.ingredientViewColor
                            foodView[i]?.addSubview(ingredientView)
                            ingredientView.frame = CGRect(x: 10, y:j, width: orderView.frame.width, height: height)
                            
                            j = j + height
                        }
                        y = y + j
                    }
                    
                    
                    
                case 1:
                    //beverages
                    self.orderViewHeight.constant += height
                    foodView[i] = .fromNib()
                    
                    foodView[i]?.tag = item.id
                    foodView[i]?.removeButton.tag = item.id
                    
                    foodView[i]?.removeButton.addTarget(self, action: #selector(removeView), for: .touchUpInside)
                    foodName = "\(item.product.name) \(item.servingSize.quantity)L"
                    foodPrice = item.cost
                    
                    foodView[i]?.descriptionLabel.text = foodName
                    foodView[i]?.priceLabel.text = "$\(foodPrice)"
                    total += foodPrice
                    
                    orderView.addSubview(foodView[i]!)
                    foodView[i]?.frame = CGRect(x: 0, y:CGFloat(y), width: orderView.frame.width, height: height)
                    
                    y = y + height
                    
                case 2:
                    //extras
                    self.orderViewHeight.constant += height
                    foodView[i] = .fromNib()
                    
                    foodView[i]?.tag = item.id
                    foodView[i]?.removeButton.tag = item.id
                    
                    foodView[i]?.removeButton.addTarget(self, action: #selector(removeView), for: .touchUpInside)
                    foodName = "\(item.product.name) "
                    foodPrice = item.cost
                    
                    foodView[i]?.descriptionLabel.text = foodName
                    foodView[i]?.priceLabel.text = "$\(foodPrice)"
                    total += foodPrice
                    
                    orderView.addSubview(foodView[i]!)
                    foodView[i]?.frame = CGRect(x: 0, y:CGFloat(y), width: orderView.frame.width, height: height)
                    
                    y = y + height
                    
                default:
                    break
                }
                
                
            }
        }
        totalLabel.text = Constants.currency + "\(total)"
        
        
    }
    
    func removeSubviews() {
        orderViewHeight.constant = 0
        
        for subview in orderView.subviews{
            if subview.isKind(of: SelectedPizzaType.self){
                subview.removeFromSuperview()
            }
            
        }
    }
    
    func removeView(sender: UIButton) {
        if let index = sender.superview?.tag {
            removeItem(index)
            configureOrder()
        }
    }
    
    func removeItem(_ orderItemIdToRemove: Int) {
        order.items = order.items.filter{$0.id != orderItemIdToRemove}
    }
    
    
    
}
