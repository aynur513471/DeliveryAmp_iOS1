//
//  SettingsViewController.swift
//  DeliveryAmp
//
//  Created by User on 7/26/17.
//
//

import UIKit

class SettingsViewController: UIViewController, UITextFieldDelegate {

    //MARK: - Outlets
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    //delivery
    @IBOutlet weak var firstNameTextField: StyleableTextField!
    @IBOutlet weak var lastNameTextField: StyleableTextField!
    @IBOutlet weak var phoneNumberTextField: StyleableTextField!
    @IBOutlet weak var emailTextField: StyleableTextField!
    @IBOutlet weak var addressTextField: StyleableTextField!
    
    //payment
    @IBOutlet weak var cardNumberTextField: StyleableTextField!
    @IBOutlet weak var expDateTextField: StyleableTextField!
    @IBOutlet weak var csvTextField: StyleableTextField!
    @IBOutlet weak var holderNameTextField: StyleableTextField!
    
    //MARK: - Variables
    var datePicker: UIPickerView = UIPickerView()
    
    var activeFieldRect: CGRect!
    
    //default y position of the view
    var yViewPosition: CGFloat!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        setDelegates()
        populateFields()
        hideKeyboardWhenTappedAround()
        
        self.expDateTextField.inputView = self.datePicker
        self.cardNumberTextField.addTarget(self, action: #selector(formatCardNumber), for: .editingChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        
        addKeyboardObservers()
        self.yViewPosition = self.view.frame.origin.y
        
        self.view.addDiagonalGradient(self.view, [MyColors.darkBlue.cgColor, MyColors.lightBlue.cgColor], self.view.frame)
        self.view.layoutIfNeeded()
    }

    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        removeKeyboardObservers()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setDelegates() {
        self.firstNameTextField.delegate = self
        self.lastNameTextField.delegate = self
        self.phoneNumberTextField.delegate = self
        self.emailTextField.delegate = self
        self.addressTextField.delegate = self
        
        self.cardNumberTextField.delegate = self
        self.expDateTextField.delegate = self
        self.csvTextField.delegate = self
        self.holderNameTextField.delegate = self
        
        self.datePicker.delegate = self
        self.datePicker.dataSource = self
        
    }
    
    func populateFields() {
        if CurrentUser.sharedInstance.exists {
            self.firstNameTextField.text = CurrentUser.sharedInstance.firstName
            self.lastNameTextField.text = CurrentUser.sharedInstance.lastName
            self.phoneNumberTextField.text = CurrentUser.sharedInstance.phone
            self.emailTextField.text = CurrentUser.sharedInstance.email
            self.addressTextField.text = CurrentUser.sharedInstance.address
        }
        
        if CurrentUser.sharedInstance.creditCard.isCompleted() {
            var cardNumber = CurrentUser.sharedInstance.creditCard.cardNumber
            cardNumber.insert("-", at: cardNumber.index(cardNumber.startIndex, offsetBy: 4))
            cardNumber.insert("-", at: cardNumber.index(cardNumber.startIndex, offsetBy: 9))
            cardNumber.insert("-", at: cardNumber.index(cardNumber.startIndex, offsetBy: 14))
            
            self.cardNumberTextField.text = cardNumber
            self.expDateTextField.text = String(CurrentUser.sharedInstance.creditCard.expMonth) + "/" + String(CurrentUser.sharedInstance.creditCard.expYear)
            self.csvTextField.text = String(CurrentUser.sharedInstance.creditCard.csvCode)
            self.holderNameTextField.text = CurrentUser.sharedInstance.creditCard.cardHolder
        }
    }
    
    @IBAction func clearAllFields(_ sender: StyleableButton) {
        self.firstNameTextField.text = nil
        self.lastNameTextField.text = nil
        self.phoneNumberTextField.text = nil
        self.emailTextField.text = nil
        self.addressTextField.text = nil
        
        self.cardNumberTextField.text = nil
        self.expDateTextField.text = nil
        self.csvTextField.text = nil
        self.holderNameTextField.text = nil
        
    }

    @IBAction func saveData(_ sender: StyleableButton) {
        
        let currentUser = CurrentUser.sharedInstance
        if checkFields() {
            
            currentUser.firstName = self.firstNameTextField.text!
            currentUser.lastName = self.lastNameTextField.text!
            currentUser.phone = self.phoneNumberTextField.text!
            currentUser.email = self.emailTextField.text!
            currentUser.address = self.addressTextField.text!
            
            if emptyCreditCardFields()  {
                self.navigationController?.popViewController(animated: true)
            } else if checkCreditCardFields() {
                currentUser.creditCard.cardHolder = self.holderNameTextField.text!
                currentUser.creditCard.cardNumber = self.cardNumberTextField.text!.components(separatedBy: "-").reduce(""){$0 + $1}
                currentUser.creditCard.csvCode = Int(self.csvTextField.text!)!
                currentUser.creditCard.expMonth = Int(self.expDateTextField.text!.components(separatedBy: "/")[0])!
                currentUser.creditCard.expYear = Int(self.expDateTextField.text!.components(separatedBy: "/")[1])!
               
                LocalRequest.updateUser(user: currentUser, { (error) in
                    print(error!)
                })
                self.navigationController?.popViewController(animated: true)
                self.tabBarController?.tabBar.isHidden = false
            }
        }
    }

    
    // MARK: - Navigation

    @IBAction func goBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        self.tabBarController?.tabBar.isHidden = false

    }

}
