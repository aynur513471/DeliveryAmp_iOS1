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
        /*
        if let field = textField as? StyleableTextField{
            field.bottomBorderColor = UIColor.black
            field.layoutSubviews()
        }*/
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
