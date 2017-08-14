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
    
    var selectedPizzaList: [[SelectedPizzaType]] = [[]]
    let font = UIFont(name: "Roboto-Italic", size: 11.0)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDelegates()
        hideKeyboardWhenTappedAround()
        
        
        customizeSegmentedControl()
        
        setDeliverytextFields()
        setPaymentFields()
      
        let sortedViews = payControl.subviews.sorted( by: { $0.frame.origin.x < $1.frame.origin.x } )
        sortedViews[0].tintColor = MyColors.segmentedControl //seg
       
        
        self.expDateTextField.inputView = self.datePicker
        
        let tap1:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(CheckoutViewController.checkbox_TouchUpInside(_:)))
        saveDeliveryLabel.addGestureRecognizer(tap1)
        let tap2:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(CheckoutViewController.checkboxSavePay_touchUpInside(_:)))
        savePayLabel.addGestureRecognizer(tap2)
        self.view.translatesAutoresizingMaskIntoConstraints = true
        
        setColors()
    

        
        
    }
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
  
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.addKeyboardObservers()
        tabBarController?.tabBar.isHidden = false
        orderViewHeight.constant = 0
        removeSubviews()
        configureOrder()
        selectedPizzaList.reserveCapacity(allProducts.count)
        for _ in 0...allProducts.count {
            selectedPizzaList.append([])
        }
        

    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.scrollView.contentInset = .zero
       
        
    
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeKeyboardObservers()
        
        orderViewHeight.constant = 0
        removeSubviews()
    }
    
    func setDeliverytextFields(){
        firstNameTextField.text = CurrentUser.sharedInstance.firstName
        lastNameTextField.text = CurrentUser.sharedInstance.lastName
        phoneNumberTextField.text = CurrentUser.sharedInstance.phone
        emailTextField.text = CurrentUser.sharedInstance.email
        addressTextField.text = CurrentUser.sharedInstance.address
        
    }
    func setPaymentFields(){
        cardNumberTextField.text = formatCardNumber( cardNumber: CurrentUser.sharedInstance.creditCard.cardNumber)
        expDateTextField.text = "\(CurrentUser.sharedInstance.creditCard.expMonth)/\(CurrentUser.sharedInstance.creditCard.expYear)"
        csvTextField.text = "\(CurrentUser.sharedInstance.creditCard.csvCode)"
        holderNameTextField.text = CurrentUser.sharedInstance.creditCard.cardHolder
    }
   

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Table View Configuration
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return order.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        return cell
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
   
    func formatCardNumber(cardNumber:String) -> String {
        var cardFormated = ""
        var k = 0
        
        for c in cardNumber.characters {
            
            if k == 4 || k == 8 || k == 12 {
            cardFormated.append("-\(c)")
            }else {
            cardFormated.append(String(c))
            }
            k = k + 1
        }
        return cardFormated
    }
    
    
    //MARK: Actions
    
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
    @IBAction func placeOrder_TouchUpInside(_ sender: Any) {
        if checkFields() {
            
            //load data in my object
            
            if emptyCreditCardFields()  {
                self.navigationController?.popViewController(animated: true)
            } else if checkCreditCardFields() {
                
                if flag1 == 1{
                    //save my delivery Options
                    
                }
                if flag2 == 1 {
                    
                    //save payment options
                }
                
                
                self.navigationController?.popViewController(animated: true)
            }
        }
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
    //MARK: Order View Configuration
    func configureOrder(){
        let nrItems = order.items.count
        for item in order.items{
            print(item.product.name)
        }
        self.orderViewHeight.constant = CGFloat(35 * nrItems)
        
        
        total = 0
        totalLabel.text = "\(total)"
        
        
        var foodView  : SelectedPizzaType
        var foodName : String
        var foodPrice : Double
        
        let height:CGFloat = 35
        var y:CGFloat = 0
       
        orderView.translatesAutoresizingMaskIntoConstraints = false
        
        for item in order.items{
            
            
           
            switch item.type{
            
            case 0 :
                //pizza
                foodView = .fromNib()
                foodView.removeButton.addTarget(self, action: #selector(removeView), for: .touchUpInside)
                foodName = "\(item.product.name) \(item.productType.name) + \(item.servingSize.name)"
                foodPrice = item.cost
                
                foodView.descriptionLabel.text = foodName
                foodView.priceLabel.text = "$\(foodPrice)"
                total += foodPrice

                
                
                orderView.addSubview(foodView)
                foodView.frame = CGRect(x: 0, y:CGFloat(y), width: orderView.frame.width, height: height)

                
                //                }else {
//                    for ingredient in item.ingredients {
//                        let ingredientView:SelectedPizzaType
//                        ingredientView = .fromNib()
//                        ingredientView.descriptionLabel.text = ingredient.name
//                        orderView.addSubview(ingredientView)
//                        foodView[i]?.frame = CGRect(x: 10, y:CGFloat(y), width: orderView.frame.width-10, height: height)
//                    }}
  
                y = y + 35
                
            case 1:
                //beverages
                foodView = .fromNib()
                foodView.removeButton.addTarget(self, action: #selector(removeView), for: .touchUpInside)
                foodName = "\(item.product.name) \(item.servingSize.quantity)L"
                foodPrice = item.cost
                
                foodView.descriptionLabel.text = foodName
                foodView.priceLabel.text = "$\(foodPrice)"
                total += foodPrice
                
                orderView.addSubview(foodView)
                foodView.frame = CGRect(x: 0, y:CGFloat(y), width: orderView.frame.width, height: height)
                y = y + 35
            
            case 2:
                //extras
                foodView = .fromNib()
                foodView.removeButton.addTarget(self, action: #selector(removeView), for: .touchUpInside)
                foodName = "\(item.product.name) "
                foodPrice = item.cost
                
                foodView.descriptionLabel.text = foodName
                foodView.priceLabel.text = "$\(foodPrice)"
                total += foodPrice
                
                orderView.addSubview(foodView)
                foodView.frame = CGRect(x: 0, y:CGFloat(y), width: orderView.frame.width, height: height)
                y = y + 35
                
            default:
                break
            }
//

//            
//                case 1 :
//                    //bauturi
//                    flag1 += 1
//                case 2 :
//                    //extras
//                    flag1 += 1
//                default: break

      
        
        }
        totalLabel.text = "\(total)"
        
        
    }
    func removeSubviews()
    {
        for subview1 in orderView.subviews{
            if subview1.isKind(of: SelectedPizzaType.self){
            subview1.removeFromSuperview()
            }
            
        }
    }
    func removeView(sender: UIButton) {
        let viewId = sender.tag
        if let cellIndex = sender.superview?.tag {
            selectedPizzaList[cellIndex] = selectedPizzaList[cellIndex].filter{$0.removeButton.tag != viewId}
            print("bays")
            removeItem(viewId)
            configureOrder()
        }
    }
    
    func removeItem(_ orderItemIdToRemove: Int) {
        order.items = order.items.filter{$0.id != orderItemIdToRemove}
    }
  
    
    
}
//MARK: Extension
extension CheckoutViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    
    
    // MARK - Check for empty fields
    
    func checkFields() -> Bool{
        var ok = true
        
        //first name
        if !Regexes.nonEmptyRegex.testMatch(input: self.firstNameTextField.text!) {
            ok = false
            self.firstNameTextField.bottomBorderColor = UIColor.red
            self.firstNameTextField.layoutSubviews()
            //self.firstNameTextField.setBottomBorder(UIColor.red)
            Alert.showDefaultAlert(for: self, title: nil, message: "Please enter your first name.")
        }
        
        // last name
        if !Regexes.nonEmptyRegex.testMatch(input: self.lastNameTextField.text!) {
            ok = false
            self.lastNameTextField.bottomBorderColor = UIColor.red
            self.lastNameTextField.layoutSubviews()
            Alert.showDefaultAlert(for: self, title: nil, message: "Please enter your last name.")
        }
        
        //email
        if !Regexes.nonEmptyRegex.testMatch(input: self.emailTextField.text!) {
            ok = false
            self.emailTextField.bottomBorderColor = UIColor.red
            self.emailTextField.layoutSubviews()
            Alert.showDefaultAlert(for: self, title: nil, message: "Please enter an email address.")
        }else if !Regexes.emailRegex.testMatch(input: self.emailTextField.text!) {
            ok = false
            self.emailTextField.bottomBorderColor = UIColor.red
            self.emailTextField.layoutSubviews()
            Alert.showDefaultAlert(for: self, title: nil, message: "Please enter a valid email address.")
        }
        
        
        //phone number
        if !Regexes.nonEmptyRegex.testMatch(input: self.phoneNumberTextField.text!) {
            ok = false
            self.phoneNumberTextField.bottomBorderColor = UIColor.red
            self.phoneNumberTextField.layoutSubviews()
        } else if !Regexes.numericRegex.testMatch(input: self.phoneNumberTextField.text!) {
            ok = false
            self.phoneNumberTextField.bottomBorderColor = UIColor.red
            self.phoneNumberTextField.layoutSubviews()
            Alert.showDefaultAlert(for: self, title: nil, message: "Please enter a correct phone number.")
        }
        
        
        //street name
        if !Regexes.nonEmptyRegex.testMatch(input: self.addressTextField.text!) {
            ok = false
            self.addressTextField.bottomBorderColor = UIColor.red
            self.addressTextField.layoutSubviews()
            
        }
        
        return ok
    }
    
    func emptyCreditCardFields() -> Bool {
        if !Regexes.nonEmptyRegex.testMatch(input: self.cardNumberTextField.text!) &&
            !Regexes.nonEmptyRegex.testMatch(input: self.expDateTextField.text!) &&
            !Regexes.nonEmptyRegex.testMatch(input: self.holderNameTextField.text!) &&
            !Regexes.nonEmptyRegex.testMatch(input: self.csvTextField.text!) {
            return true
        }
        return false
    }
    
    func checkCreditCardFields() -> Bool {
        var ok = true
        
        /* user has at least 1 textField completed and wants to add cc details */
        if !Regexes.nonEmptyRegex.testMatch(input: self.cardNumberTextField.text!) {
            ok = false
            self.cardNumberTextField.bottomBorderColor = UIColor.red
            self.cardNumberTextField.layoutSubviews()
            Alert.showDefaultAlert(for: self, title: nil, message: "Please enter your card number.")
        }else if !Regexes.nonEmptyRegex.testMatch(input: self.csvTextField.text!) {
            ok = false
            self.csvTextField.bottomBorderColor = UIColor.red
            self.csvTextField.layoutSubviews()
            Alert.showDefaultAlert(for: self, title: nil, message: "Please enter the CSV code.")
        }else if !Regexes.nonEmptyRegex.testMatch(input: self.expDateTextField.text!) {
            ok = false
            self.expDateTextField.bottomBorderColor = UIColor.red
            self.expDateTextField.layoutSubviews()
            Alert.showDefaultAlert(for: self, title: nil, message: "Please enter the card expiration date.")
        } else if !Regexes.nonEmptyRegex.testMatch(input: self.holderNameTextField.text!) {
            ok = false
            self.holderNameTextField.bottomBorderColor = UIColor.red
            self.holderNameTextField.layoutSubviews()
            Alert.showDefaultAlert(for: self, title: nil, message: "Please enter the card holder name.")
        }
        
        if !ok {
            return false
        }
        
        if !checkCardNumber(self.cardNumberTextField.text!) {
            ok = false
            self.cardNumberTextField.bottomBorderColor = UIColor.red
            self.cardNumberTextField.layoutSubviews()
            Alert.showDefaultAlert(for: self, title: nil, message: "Wrong card number.")
        } else if !checkCSVCode(self.csvTextField.text!) {
            ok = false
            self.csvTextField.bottomBorderColor = UIColor.red
            self.csvTextField.layoutSubviews()
            Alert.showDefaultAlert(for: self, title: nil, message: "Wrong CSV code.")
        } else if !checkExpDate(self.expDateTextField.text!) {
            ok = false
            self.expDateTextField.bottomBorderColor = UIColor.red
            self.expDateTextField.layoutSubviews()
            Alert.showDefaultAlert(for: self, title: nil, message: "Wrong expiration date.")
        } else if !checkHolder(self.holderNameTextField.text!) {
            ok = false
            self.holderNameTextField.bottomBorderColor = UIColor.red
            self.holderNameTextField.layoutSubviews()
            Alert.showDefaultAlert(for: self, title: nil, message: "Wrong card holder name format.")
        }
        
        
        return ok
    }
    
    func checkCardNumber(_ cardNumber: String) -> Bool {
        if Regexes.creditCardNumberRegex.testMatch(input: cardNumber) {
            if cardNumber.characters.count == 19 {
                return true
            }
        }
        return false
    }
    
    func checkCSVCode(_ csvCode: String) -> Bool {
        if Regexes.numericRegex.testMatch(input: csvCode) {
            if csvCode.characters.count == 3 || csvCode.characters.count == 4 {
                return true
            }
        }
        return false
    }
  
    func checkExpDate(_ expDate: String) -> Bool {
         let dateFormatter = DateFormatter()
         dateFormatter.dateFormat = "MM/yyyy"
         if dateFormatter.date(from: expDate)! == Date() {
         return true
         }
         if dateFormatter.date(from: expDate)! < Date() {
         return false
         }
        return true
    }
    
    func checkHolder(_ cardHolder: String) -> Bool {
        if cardHolder.contains(" ") {
            return true
        }
        return false
    }
    
    
    
    
    //MARK: PickerView Functions
    // picker view for expiration date input
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return 12
        } else {
            return 10
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return String(row + 1)
        } else {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy"
            return String(Int(dateFormatter.string(from: Date()))! + row)
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy"
            let yearRow = pickerView.selectedRow(inComponent: 1)
            self.expDateTextField.text = String(row + 1) + "/" + String(Int(dateFormatter.string(from: Date()))! + yearRow)
        } else {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy"
            self.expDateTextField.text = String(pickerView.selectedRow(inComponent: 0) + 1) + "/" + String(Int(dateFormatter.string(from: Date()))! + row)
        }
    }
    
    
    
 
   
    
    
    //MARK: TextField Functions

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool{


        activeFieldRect = textField.frame
        if let superview = textField.superview{
            activeFieldRect = CGRect(x: textField.frame.origin.x, y: superview.frame.origin.y + textField.frame.origin.y, width: textField.frame.size.width, height: textField.frame.size.height)
        }
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        activeFieldRect = nil
        
//        //move to next text field
        let nextTag: Int = textField.tag + 1
        if let nextResponder = self.view.viewWithTag(nextTag){
            nextResponder.becomeFirstResponder()
        }else{
            
            textField.resignFirstResponder()
        }
        
        return true
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
        //code to recognize if backspace was pressed
    {
        let  char = string.cString(using: String.Encoding.utf8)!
        let isBackSpace = strcmp(char, "\\b")
        
        if textField == self.cardNumberTextField{
            
            
            if (isBackSpace == -92) {
                //if character to delete is “-”, delete “-” and the character before it
                if let lasCharacter = textField.text?.characters.last,
                    lasCharacter == "-", textField.text!.characters.count >= 2{
                    textField.text?.characters.removeLast()
                    textField.text?.characters.removeLast()
                    return false
                }
            }else{
                //add “-” after every 4 characters
                switch textField.text!.characters.count {
                case 4, 9, 14:
                    textField.text?.append("-")
                default:
                    break
                }
                
                //limit for card number is a set of 4 numbers with 4 characters
                if textField.text!.characters.count == 19{
                    return false
                }
            }
            return true
        }else if textField == self.csvTextField{
            let finalString = string + self.csvTextField.text!
            
            //don’t paste if the nr of characters are greater than 4
            if finalString.characters.count > 4{
                return false
            }
            
            //don’t allow to write more than 3 characters
            if !(isBackSpace == -92), textField.text!.characters.count == 4 {
                return false
            }
        }
        
        return true
    }
 
   
    //MARK: Keyboard Observers
    func addKeyboardObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
    }
    
    func removeKeyboardObservers(){
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func keyboardWillShow(_ notification: Notification) {
            if let info = notification.userInfo, let keyboardRect = (info[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue,
            activeFieldRect != nil{
                let keyboardSize = keyboardRect.size
                let contentInsets = UIEdgeInsetsMake(0.0, 0.0, keyboardSize.height+20, 0.0)
                scrollView.contentInset = contentInsets
                scrollView.scrollIndicatorInsets = contentInsets
                var aRect : CGRect = self.view.frame
                aRect.size.height = aRect.size.height - keyboardSize.height
                if !aRect.contains(activeFieldRect.origin){
                    self.scrollView.scrollRectToVisible(self.activeFieldRect, animated: true)
                }
        }
        
    }
    
    
    func keyboardWillHide(_ notification: Notification) {
        
        dismissKeyboard()
    }
    
    //MARK: Dismiss Keyboard
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        scrollView.contentInset = UIEdgeInsets.zero
        scrollView.scrollIndicatorInsets = UIEdgeInsets.zero
        self.view.endEditing(true)
        //dismissTextFields()
    }
    
    func dismissTextFields(){
        self.firstNameTextField.resignFirstResponder()
        self.lastNameTextField.resignFirstResponder()
        self.phoneNumberTextField.resignFirstResponder()
        self.emailTextField.resignFirstResponder()
        self.addressTextField.resignFirstResponder()
        self.cardNumberTextField.resignFirstResponder()
        self.csvTextField.resignFirstResponder()
        self.expDateTextField.resignFirstResponder()
        self.holderNameTextField.resignFirstResponder()
    }
 
    
}
