//
//  CheckoutViewController.swift
//  DeliveryAmp
//
//  Created by User on 8/4/17.
//

import UIKit
import Foundation

class CheckoutViewController: UIViewController, UITextFieldDelegate, UIScrollViewDelegate {
    
    
    
    
    //MARK: Outlets
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var viewWithShadow: ViewWithShadow!
    @IBOutlet weak var paymentView: UIView!
    @IBOutlet weak var checkbox1: UIButton!
    @IBOutlet weak var checkbox2: UIButton!
    @IBOutlet weak var orderHistoryBtn: StyleableButton!
    
    
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
    
    let font = UIFont(name: "Roboto-Italic", size: 11.0)
    var foodView:[SelectedPizzaType?]  = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDelegates()
        hideKeyboardWhenTappedAround()
        setColors()
        
        customizeSegmentedControl()
       
        
        let sortedViews = payControl.subviews.sorted( by: { $0.frame.origin.x < $1.frame.origin.x } )
        sortedViews[0].tintColor = MyColors.segmentedControl //seg
        
        
        self.expDateTextField.inputView = self.datePicker
        
        addTapToCheckboxes()

    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.addKeyboardObservers()
        tabBarController?.tabBar.isHidden = false
        orderViewHeight.constant = 0
        
        if CurrentUser.sharedInstance.creditCard.csvCode != -1 && CurrentUser.sharedInstance.address != "" {
            setDeliverytextFields()
            setPaymentFields()
        }

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
        saveDeliveryLabel.addGestureRecognizer(tap1)
        let tap2:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(CheckoutViewController.checkboxSavePay_touchUpInside(_:)))
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
        cardNumberTextField.text = CurrentUser.sharedInstance.creditCard.cardNumber
        expDateTextField.text = "\(CurrentUser.sharedInstance.creditCard.expMonth)/\(CurrentUser.sharedInstance.creditCard.expYear)"
        csvTextField.text = "\(CurrentUser.sharedInstance.creditCard.csvCode)"
        holderNameTextField.text = CurrentUser.sharedInstance.creditCard.cardHolder
    }
    
//    func formatCardNumber(cardNumber:String) -> String {
//        var cardFormated = ""
//        var k = 0
//        
//        for c in cardNumber.characters {
//            
//            if k == 4 || k == 8 || k == 12 {
//                cardFormated.append("-\(c)")
//            }else {
//                cardFormated.append(String(c))
//            }
//            k = k + 1
//        }
//        return cardFormated
//    }
    
    func setColors(){
        orderView.backgroundColor = MyColors.buttonDefaultBackgroundColor
        dismissBtn.backgroundColor = MyColors.buttonDefaultBackgroundColor
        placeOrderBtn.backgroundColor = MyColors.buttonDefaultBackgroundColor
        payControl.backgroundColor = MyColors.buttonDefaultBackgroundColor
        firstNameTextField.backgroundColor = MyColors.buttonDefaultBackgroundColor
        lastNameTextField.backgroundColor = MyColors.buttonDefaultBackgroundColor
        phoneNumberTextField.backgroundColor = MyColors.buttonDefaultBackgroundColor
        emailTextField.backgroundColor = MyColors.buttonDefaultBackgroundColor
        cardNumberTextField.backgroundColor = MyColors.buttonDefaultBackgroundColor
        expDateTextField.backgroundColor = MyColors.buttonDefaultBackgroundColor
        holderNameTextField.backgroundColor = MyColors.buttonDefaultBackgroundColor
        orderHistoryBtn.backgroundColor = MyColors.buttonDefaultBackgroundColor
        addressTextField.backgroundColor = MyColors.buttonDefaultBackgroundColor
        csvTextField.backgroundColor = MyColors.buttonDefaultBackgroundColor
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

    //MARK: Segmented Control
    
    func customizeSegmentedControl(){
        payControl.layer.cornerRadius = 15 // Don't let background bleed
        payControl.layer.borderWidth = 1
        payControl.layer.borderColor = MyColors.buttonBorderColor.cgColor
        payControl.backgroundColor = UIColor.white
        payControl.tintColor = MyColors.buttonTextColor
        payControl.clipsToBounds = true
        for segment in self.payControl.subviews{
            for subview in segment.subviews {
                if subview.isKind(of: UILabel.self), let label = subview as? UILabel {
                    label.numberOfLines = 2
                }
            }
            
        }
        
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
    //Place Order Button
    @IBAction func placeOrder_TouchUpInside(_ sender: Any) {
        if checkFields() {
            
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
            
            if emptyCreditCardFields()  {
                self.navigationController?.popViewController(animated: true)
            } else if checkCreditCardFields() {
                
                
                if flag2 == 1 {
                    
                    //save payment options
                    var strings = expDateTextField.text?.components(separatedBy: "/")
                    CurrentUser.sharedInstance.creditCard.cardNumber = cardNumberTextField.text!
                    CurrentUser.sharedInstance.creditCard.expMonth = Int((strings?[0])!)!
                    CurrentUser.sharedInstance.creditCard.expYear = Int((strings?[1])!)!
                    CurrentUser.sharedInstance.creditCard.csvCode = Int(csvTextField.text!)!
                    CurrentUser.sharedInstance.creditCard.cardHolder = holderNameTextField.text!
                    LocalRequest.updateUser(user: CurrentUser.sharedInstance, { (error) in
                        print(error!)
                    })
                }
                
               
                self.navigationController?.popViewController(animated: true)
            }
            LocalRequest.postOrderToOrderHistory(order: order, { (error) in
                print(error!)
            })
        }
    }
    
    
   
    //MARK: Order View Configuration
    func configureOrder(){
        removeSubviews()
        
        let nrItems = order.items.count
        foodView  = [SelectedPizzaType?](repeating: nil,count : nrItems)

        
        print("order.items : ")
        for item in order.items{
            
            print(item.product.name)
        }
        
        
        
        total = 0
        totalLabel.text = "\(total)"
        
        
        
        
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
                if item.ingredients.count <= 0{
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
                }else {
                    self.orderViewHeight.constant += height
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
                        let ingredientView:SelectedPizzaType
                        ingredientView = .fromNib()
                        ingredientView.descriptionLabel.text = "\(Int(ingredient.quantity)) x \(ingredient.name)"
                        ingredientView.descriptionLabel.textColor = MyColors.myBlack
                        ingredientView.priceLabel.text = "$\(ingredient.cost)"
                        ingredientView.priceLabel.textColor = MyColors.myBlack
                        ingredientView.removeButton.isHidden = true
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
        totalLabel.text = "\(total)"
        
        
    }
    
    func removeSubviews()
    {
        orderViewHeight.constant = 0
        
        for subview in orderView.subviews{
            if subview.isKind(of: SelectedPizzaType.self){
                subview.removeFromSuperview()
            }
            
        }
    }
    
    func removeView(sender: UIButton) {
        //let viewId = sender.tag
        
        if let index = sender.superview?.tag {
            print("bays")
            removeItem(index)
            configureOrder()
        }
    }
    
    func removeItem(_ orderItemIdToRemove: Int) {
        order.items = order.items.filter{$0.id != orderItemIdToRemove}
    }
    
    
    
}
