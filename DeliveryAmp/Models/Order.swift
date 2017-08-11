//
//  Order.swift
//  DeliveryAmp
//
//  Created by User on 8/10/17.
//
//

import Foundation
import SwiftyJSON

struct OrderPropertyKey {
    
    static let dateKey = "date"
    static let addressKey = "address"
    static let deliveryDetailsHadChangedKey = "deliveryDetailsHadChanged"
    static let emailKey = "email"
    static let firstNameKey = "firstName"
    static let lastNameKey = "lastName"
    static let phoneKey = "phone"
    static let totalCostKey = "totalCost"
    static let orderHasItemsKey = "orderHasItems"
    static let itemsKey = "items"
    
}

class Order: NSObject {
    
    var date: String
    var address: String
    var deliveryDetailsHadChanged: Bool
    var email: String
    var firstName: String
    var lastName: String
    var phone: String
    var totalCost: Double
    var orderHasItems: Bool
    var items: [OrderItem]
    
    
    override init() {
        self.date = ""
        self.address = ""
        self.deliveryDetailsHadChanged = false
        self.email = ""
        self.firstName = ""
        self.lastName = ""
        self.phone = ""
        self.totalCost = -1
        self.orderHasItems = false
        self.items = []
        
    }
    
    init(date: String, address: String, deliveryDetailsHadChanged: Bool, email: String, firstName: String, lastName: String, phone: String, totalCost: Double, orderHasItems: Bool, items: [OrderItem]) {
        self.date = date
        self.address = address
        self.deliveryDetailsHadChanged = deliveryDetailsHadChanged
        self.email = email
        self.firstName = firstName
        self.lastName = lastName
        self.phone = phone
        self.totalCost = totalCost
        self.orderHasItems = orderHasItems
        self.items = items
    }
}

extension Order {
    static func decode(_ json: [String: JSON]) -> Order? {
        
        var items: [OrderItem] = []
        if let itemArray = json[OrderPropertyKey.itemsKey]?.array {
            for itemJSON in itemArray{
                if let itemDecoded = OrderItem.decode(itemJSON) {
                    items.append(itemDecoded)
                }
            }
        }
        
        guard let date = json[OrderPropertyKey.dateKey]?.string,
            let address = json[OrderPropertyKey.addressKey]?.string,
            let deliveryDetailsHadChanged = json[OrderPropertyKey.deliveryDetailsHadChangedKey]?.bool,
            let email = json[OrderPropertyKey.emailKey]?.string,
            let firstName = json[OrderPropertyKey.firstNameKey]?.string,
            let lastName = json[OrderPropertyKey.lastNameKey]?.string,
            let phone = json[OrderPropertyKey.phoneKey]?.string,
            let totalCost = json[OrderPropertyKey.totalCostKey]?.double,
            let orderHasItems = json[OrderPropertyKey.orderHasItemsKey]?.bool
            else{
                return nil
        }
        
        return Order(date: date, address: address, deliveryDetailsHadChanged: deliveryDetailsHadChanged, email: email, firstName: firstName, lastName: lastName, phone: phone, totalCost: totalCost, orderHasItems: orderHasItems, items: items)
    }
}
