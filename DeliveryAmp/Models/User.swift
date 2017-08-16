//
//  User.swift
//  IvoryiOS
//
//  Created by Cristina Oana on 6/23/17.
//  Copyright © 2017 Team Extension. All rights reserved.
//

import Foundation
import SwiftyJSON

struct UserPropertyKey{
    static let addressKey = "address"
    static let firstNameKey = "firstName"
    static let lastNameKey = "lastName"
    static let emailKey = "email"
    static let phoneKey = "phone"
    static let creditCardKey = "creditCard"
}


class User: NSObject{

    var address: String
    var firstName: String
    var lastName: String
    var email: String
    var phone: String
    var creditCard: CreditCard
    
    
    
    override init(){

        self.address = ""
        self.firstName = ""
        self.lastName = ""
        self.email = ""
        self.phone = ""
        self.creditCard = CreditCard()
    }
    
    init(address: String, firstName: String, lastName: String, email: String, phone: String, creditCard: CreditCard) {
        self.address = address
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.phone = phone
        self.creditCard = creditCard
    }

    
    
    func copy(_ user: User){
        self.firstName = user.firstName
        self.lastName = user.lastName
        self.email = user.email
        self.phone = user.phone
        self.address = user.address
        self.creditCard.copy(user.creditCard)
    }
    
    //checks
    var exists: Bool{
        return self.email != ""
    }
    
}

extension User{
    

    static func decode(_ json: [String: JSON]) -> User?{
        
        var creditCard = CreditCard()
        if let creditCardJSON = json[UserPropertyKey.creditCardKey]?.dictionary,
            let creditCardDecoded = CreditCard.decode(creditCardJSON) {
            creditCard = creditCardDecoded
        }
        
        let firstName = json[UserPropertyKey.firstNameKey]?.string ?? ""
        let lastName = json[UserPropertyKey.lastNameKey]?.string ?? ""
        let email = json[UserPropertyKey.emailKey]?.string ?? ""
        let phone = json[UserPropertyKey.phoneKey]?.string ?? ""
        let address = json[UserPropertyKey.addressKey]?.string ?? ""
       
        guard email != ""
            else{
                return nil
        }
        
        return User(
            address: address,
            firstName: firstName,
            lastName: lastName,
            email: email,
            phone: phone,
            creditCard: creditCard
        )
    }
    
}

//MARK: Current User
final class CurrentUser{
    
    static var sharedInstance = User()
    
    init(){
    }
}
