//
//  PayPalViewController.swift
//  DeliveryAmp
//
//  Copyright © 2017 ThemeDimension.com
//

import UIKit

class PayPalViewController: UIViewController, PayPalPaymentDelegate {

    //MARK: - Variables
    var payPalConfiguration: PayPalConfiguration?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        PayPalMobile.preconnect(withEnvironment: PayPalEnvironmentSandbox)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    //MARK: - Actions
    @IBAction func back_TouchUpInside(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func goToPayPal(_ sender: Any) {
        let payment = PayPalPayment()
        payment.amount = NSDecimalNumber(string: "\(order.totalCost)")
        payment.currencyCode = "USD"
        payment.shortDescription = "Total";
        payment.intent = PayPalPaymentIntent.sale
        if (payment.processable) {
            var paymentViewController: PayPalPaymentViewController?
            paymentViewController = PayPalPaymentViewController(payment: payment, configuration: payPalConfiguration, delegate: self)
            present(paymentViewController!, animated: true, completion: nil)
        } else {
            
        }
    }
    
    
    //MARK: - Configuration
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        payPalConfiguration = PayPalConfiguration()
        payPalConfiguration?.acceptCreditCards = true
        payPalConfiguration?.payPalShippingAddressOption = .both
    }
    
    
    //MARK: - PayPal Functions
    func payPalPaymentViewController(_ paymentViewController: PayPalPaymentViewController, didComplete completedPayment: PayPalPayment) {
        dismiss(animated: true, completion: nil)
    }
    
    func payPalPaymentDidCancel(_ paymentViewController: PayPalPaymentViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    func verifyCompletedPayment(_ completedPayment: PayPalPayment) {
        let _: Data? = try? JSONSerialization.data(withJSONObject: completedPayment.confirmation, options: [])
    }
    
    
}
