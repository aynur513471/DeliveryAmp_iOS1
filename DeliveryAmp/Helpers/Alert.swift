//
//  Alert.swift
//  DeliveryAmp
//
//  Copyright © 2017 ThemeDimension.com
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
