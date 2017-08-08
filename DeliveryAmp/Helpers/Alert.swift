//
//  Alert.swift
//  DeliveryAmp
//
//  Created by User on 8/3/17.
//
//

import Foundation
import UIKit

class Alert{
    
    static func showDefaultAlert(for viewController: UIViewController, title: String?, message: String?){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(okAction)
        viewController.present(alert, animated: true, completion: nil)
    }
    
}
