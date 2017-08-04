//
//  SettingsViewControllerExtension.swift
//  DeliveryAmp
//
//  Created by User on 7/31/17.
//
//

import Foundation
import UIKit

extension SettingsViewController: UIPickerViewDelegate, UIPickerViewDataSource  {
    
    
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
        /*  let dateFormatter = DateFormatter()
         dateFormatter.dateFormat = "MM/yyyy"
         if dateFormatter.date(from: expDate)! == Date() {
         return true
         }
         if dateFormatter.date(from: expDate)! < Date() {
         return false
         }*/
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
    
    
    //MARK: formatCardNumber
    func formatCardNumber() {
        
        let componentsCount =  cardNumberTextField.text?.components(separatedBy: "-").count
        
        switch (cardNumberTextField.text?.characters.count)! {
        case 4:
            if componentsCount == 1 {
                cardNumberTextField.text?.append("-")
            }
            break
        case 9:
            if componentsCount == 2 {
                cardNumberTextField.text?.append("-")
            }
            break
        case 14:
            if componentsCount == 3 {
                cardNumberTextField.text?.append("-")
            }
            break
        default:
            break
        }
    }
    
    
    //MARK: TextField Functions
    
    
    //MARK: TextField Functions
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if let superview = textField.superview{
            activeFieldRect = CGRect(x: textField.frame.origin.x, y: superview.frame.origin.y + textField.frame.origin.y, width: textField.frame.size.width, height: textField.frame.size.height)
        }
    
        if let field = textField as? StyleableTextField{
            field.bottomBorderColor = UIColor.black
            field.layoutSubviews()
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        activeFieldRect = nil
        
        //move to next text field
        let nextTag: Int = textField.tag + 1
        if let nextResponder = self.view.viewWithTag(nextTag){
            nextResponder.becomeFirstResponder()
        }else{
            textField.resignFirstResponder()
        }
        
        return false
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
        if let info = notification.userInfo,
            let offsetRect = (info[UIKeyboardFrameEndUserInfoKey] as AnyObject).cgRectValue,
            activeFieldRect != nil{
            let offset = offsetRect.size
            self.view.frame.origin.y = yViewPosition
            if (activeFieldRect.origin.y + activeFieldRect.size.height + 10.0) > self.view.frame.size.height - offset.height{
                self.view.frame.origin.y -= activeFieldRect.origin.y - (self.view.frame.size.height - offset.height) + activeFieldRect.size.height + 40.0
            }
        }
    }
    
    
    func keyboardWillHide(_ notification: Notification) {
        scrollView.contentInset = UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0)
        dismissKeyboard()
    }
    
    //MARK: Dismiss Keyboard
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        dismissTextFields()
        self.view.frame.origin.y = self.yViewPosition
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
