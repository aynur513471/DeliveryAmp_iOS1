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
        hideKeyboardWhenTappedAround()
        
        self.expDateTextField.inputView = self.datePicker
        self.cardNumberTextField.addTarget(self, action: #selector(formatCardNumber), for: .editingChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        addKeyboardObservers()
        self.yViewPosition = self.view.frame.origin.y
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        removeKeyboardObservers()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
