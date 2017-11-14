//
//  ServingSizesFood.swift
//  DeliveryAmp
//
//  Copyright © 2017 ThemeDimension.com
//

import Foundation
import SwiftyJSON


struct ServingSizePropertyKey{
    static let idKey = "id"
    static let nameKey = "name"
    static let quantityKey = "quantity"
    static let priceKey = "price"
}

class ServingSize: NSObject {

    var id: Int
    var name: String
    var quantity: Double
    var price: Double
    
    override init() {
        self.id = -1
        self.name = ""
        self.quantity = -1
        self.price = -1
    }
    
    init(id: Int, name: String, quantity: Double, price: Double) {
        self.id = id
        self.name = name
        self.quantity = quantity
        self.price = price
    }
    
    func copy(_ servingSize: ServingSize) {
        self.id = servingSize.id
        self.name = servingSize.name
        self.quantity = servingSize.quantity
        self.price = servingSize.price
    }
    
}

extension ServingSize {
    
    static func decode(_ json: [String: JSON]) -> ServingSize? {
        guard let id = json[ServingSizePropertyKey.idKey]?.int,
            let name = json[ServingSizePropertyKey.nameKey]?.string,
            let quantity = json[ServingSizePropertyKey.quantityKey]?.double,
            let price = json[ServingSizePropertyKey.priceKey]?.double
            else {
                return nil
        }
        
        return ServingSize(id: id, name: name, quantity: quantity, price: price)
    }
}
