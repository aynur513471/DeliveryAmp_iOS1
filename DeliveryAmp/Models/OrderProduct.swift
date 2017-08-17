//
//  OrderProduct.swift
//  DeliveryAmp
//
//  Created by User on 8/10/17.
//
//

import Foundation
import SwiftyJSON

struct OrderProductPropertyKey{
    static let idKey = "id"
    static let nameKey = "name"
    static let priceKey = "price"
}

class OrderProduct: NSObject {
    
    var id: Int
    
    var name: String
    var price: Double
    
    override init() {
        self.id = -1
        self.name = ""
        self.price = -1
    }
    
    init(id: Int, name: String, price: Double) {
        self.id = id
        self.name = name
        self.price = price
    }
 
    func copy(_ product: OrderProduct) {
        self.id = product.id
        self.name = product.name
        self.price = product.price
    }
    
}

extension OrderProduct {
    
    static func decode(_ json: [String: JSON]) -> OrderProduct? {
        guard let id = json[OrderProductPropertyKey.idKey]?.int,
            let name = json[OrderProductPropertyKey.nameKey]?.string,
            let price = json[OrderProductPropertyKey.priceKey]?.double
            else {
                return nil
        }
        
        return OrderProduct(id: id, name: name, price: price)
    }
    
}
