//
//  AppDelegate.swift
//  DeliveryAmp
//
//  Copyright © 2017 ThemeDimension.com
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        PayPalMobile.initializeWithClientIds(forEnvironments: [PayPalEnvironmentProduction: PAYPAL_PROD_KEY, PayPalEnvironmentSandbox: PAYPAL_SANDBOX_KEY])
        
        return true
    }

}

