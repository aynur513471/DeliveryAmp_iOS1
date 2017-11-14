//
//  CreditCard.swift
//  IvoryiOS
//
//  Copyright © 2017 ThemeDimension.com
//

import Foundation
import SwiftyJSON


struct CreditCardPropertyKey{
    static let cardNumberKey = "cardNumber"
    static let csvCodeKey = "csvCode"
    static let expMonthKey = "expMonth"
    static let expYearKey = "expYear"
    static let cardHolderKey = "cardHolder"
}

class CreditCard: NSObject {
    
    var cardNumber: String
    var csvCode: Int
    var expMonth: Int
    var expYear: Int
    var cardHolder: String
    
    override init() {
        self.cardNumber = ""
        self.csvCode = -1
        self.expMonth = -1
        self.expYear = -1
        self.cardHolder = ""
    }
    
    init(cardNumber: String, csvCode: Int, expMonth: Int, expYear: Int, cardHolder: String) {
        self.cardNumber = cardNumber
        self.csvCode = csvCode
        self.expMonth = expMonth
        self.expYear = expYear
        self.cardHolder = cardHolder
    }
    
    func copy(_ creditCard: CreditCard){
        self.cardNumber = creditCard.cardNumber
        self.csvCode = creditCard.csvCode
        self.expMonth = creditCard.expMonth
        self.expYear = creditCard.expYear
        self.cardHolder = creditCard.cardHolder
    }
}


extension CreditCard {
    
    
    static func decode(_ json: [String: JSON]) -> CreditCard? {
    
        let cardNumber = json[CreditCardPropertyKey.cardNumberKey]?.string ?? ""
        let csvCode = json[CreditCardPropertyKey.csvCodeKey]?.int ?? -1
        let expMonth = json[CreditCardPropertyKey.expMonthKey]?.int ?? -1
        let expYear = json[CreditCardPropertyKey.expYearKey]?.int ?? -1
        let cardHolder = json[CreditCardPropertyKey.cardHolderKey]?.string ?? ""
       

        return CreditCard(
            cardNumber: cardNumber,
            csvCode: csvCode,
            expMonth: expMonth,
            expYear: expYear,
            cardHolder: cardHolder
        )
    }
    
    func isCompleted() -> Bool {
        if self.cardHolder != "" &&
            self.cardNumber != "" &&
            self.csvCode != -1 &&
            self.expYear != -1 &&
            self.expMonth != -1 {
            return true
        }
        return false
    }

}



