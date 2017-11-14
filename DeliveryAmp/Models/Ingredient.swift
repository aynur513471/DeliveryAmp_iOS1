//
//  Ingredient.swift
//  DeliveryAmp
//
//  Copyright © 2017 ThemeDimension.com
//

import Foundation
import SwiftyJSON

struct IngredientPropertyKey{
    static let idKey = "id"
    static let nameKey = "name"
    static let quantityKey = "quantity"
    static let priceKey = "price"
}

class Ingredient: NSObject {
    
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
    
    func copy(_ ingredient: Ingredient) {
        self.id = ingredient.id
        self.name = ingredient.name
        self.price = ingredient.price
    }
    
}

extension Ingredient {
    
    static func decode(_ json: [String: JSON]) -> Ingredient? {
        guard let id = json[IngredientPropertyKey.idKey]?.int,
            let name = json[IngredientPropertyKey.nameKey]?.string,
            let price = json[IngredientPropertyKey.priceKey]?.double
            else {
                return nil
        }
        
        return Ingredient(id: id, name: name, price: price)
    }
        
}
