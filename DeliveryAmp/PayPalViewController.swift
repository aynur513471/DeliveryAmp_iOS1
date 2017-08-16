//
//  PayPalViewController.swift
//  DeliveryAmp
//
//  Created by User on 8/9/17.
//

import UIKit

class PayPalViewController: UIViewController, PayPalPaymentDelegate {

    var payPalConfiguration: PayPalConfiguration?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        payPalConfiguration = PayPalConfiguration()
        payPalConfiguration?.acceptCreditCards = true

        payPalConfiguration?.payPalShippingAddressOption = .both
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        PayPalMobile.preconnect(withEnvironment: PayPalEnvironmentSandbox)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
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
