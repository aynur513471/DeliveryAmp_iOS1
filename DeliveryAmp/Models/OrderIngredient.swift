//
//  Ingredient.swift
//  DeliveryAmp
//
//  Created by User on 8/10/17.
//
//

import Foundation
import SwiftyJSON

struct OrderIngredientPropertyKey{
    static let idKey = "id"
    static let nameKey = "name"
    static let costKey = "cost"
    static let quantityKey = "quantity"
}

class OrderIngredient: NSObject {
    
    var id: Int
    
    var name: String
    var cost: Double
    var quantity: Int
    
    override init() {
        self.id = -1
        self.name = ""
        self.cost = -1
        self.quantity = -1
    }
    
    init(id: Int, name: String, cost: Double, quantity: Int) {
        self.id = id
        self.name = name
        self.cost = cost
        self.quantity = quantity
    }
}

extension OrderIngredient {
    
    static func decode(_ json: JSON) -> OrderIngredient? {
        guard let id = json[OrderIngredientPropertyKey.idKey].int,
            let name = json[OrderIngredientPropertyKey.nameKey].string,
            let cost = json[OrderIngredientPropertyKey.costKey].double,
            let quantity = json[OrderIngredientPropertyKey.quantityKey].int
            else {
                return nil
        }
        
        return OrderIngredient(id: id, name: name, cost: cost, quantity: quantity)
    }
    
}
