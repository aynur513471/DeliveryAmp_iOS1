//
//  ApiParameters.swift
//  DeliveryAmp
//
//  Created by User on 8/11/17.
//
//

import Foundation
import SwiftyJSON
import UIKit

typealias BodyParameters = [String: Any]
typealias HeaderParameters = [String: String]

extension APIRouter{
    
    //MARK: GET

    /*
    
    func generateHeaderParametersForGetUserByEmail(email: String) -> HeaderParameters{
        let parameters: HeaderParameters = ["email": email]
        
        return parameters
    }
*/
    
    //MARK: POST

    
    //update user
    
    /*
    func generateBodyParametersForPostUpdateUser(user: User) -> BodyParameters {
        
        var parameters: BodyParameters = [:]
        parameters["action"] = "update"
        
        var creditCard: BodyParameters = [:]
        
        if CurrentUser.sharedInstance.firstName != user.firstName.trim {
            parameters[UserPropertyKey.firstNameKey] = user.firstName.trim
        }
        
        if CurrentUser.sharedInstance.lastName != user.lastName.trim{
            parameters[UserPropertyKey.lastNameKey] = user.lastName.trim
        }
        
        if CurrentUser.sharedInstance.phone != user.phone.trim {
            parameters[UserPropertyKey.phoneKey] = user.phone.trim
        }
        
        if CurrentUser.sharedInstance.email != user.email.trim {
            parameters[UserPropertyKey.emailKey] = user.email.trim
        }
        
        if CurrentUser.sharedInstance.address != user.address.trim {
            address[AddressPropertyKey.streetKey] = user.address.street.trim
        }
        
        if CurrentUser.sharedInstance.creditCard.cardNumber != user.creditCard.cardNumber.trim {
            address[CreditCardPropertyKey.cardNumberKey] = user.creditCard.cardNumber.trim
        }
        
        if CurrentUser.sharedInstance.creditCard.cardHolder != user.creditCard.cardHolder.trim {
            address[CreditCardPropertyKey.cardHolderKey] = user.creditCard.cardHolder.trim
        }
        
        if CurrentUser.sharedInstance.creditCard.csvCode != user.creditCard.csvCode {
            address[CreditCardPropertyKey.csvCodeKey] = user.creditCard.csvCode
        }
        
        if CurrentUser.sharedInstance.creditCard.expYear != user.creditCard.expYear {
            address[CreditCardPropertyKey.expYearKey] = user.creditCard.expYear
        }
        
        if CurrentUser.sharedInstance.creditCard.expMonth != user.creditCard.expMonth {
            address[CreditCardPropertyKey.expMonthKey] = user.creditCard.expMonth
        }
        
        
        parameters[UserPropertyKey.addressKey] = address
        parameters[UserPropertyKey.creditCardKey] = creditCard
        
        return parameters
    }
    */
 }
