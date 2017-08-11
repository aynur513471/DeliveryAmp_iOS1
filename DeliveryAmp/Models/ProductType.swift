//
//  ServingSizesFood.swift
//  DeliveryAmp
//
//  Created by User on 8/4/17.
//
//

import Foundation
import SwiftyJSON

struct ProductTypePropertyKey{
    static let idKey = "id"
    static let nameKey = "name"
    static let priceKey = "price"
}

class ProductType: NSObject {
    
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

    func copy(_ productType: ProductType) {
        self.id = productType.id
        self.name = productType.name
        self.price = productType.price
    }
}

extension ProductType {
    
    static func decode(_ json: [String: JSON]) -> ProductType? {
        guard let id = json[ProductTypePropertyKey.idKey]?.int,
            let name = json[ProductTypePropertyKey.nameKey]?.string,
            let price = json[ProductTypePropertyKey.priceKey]?.double
            else {
                return nil
        }
        
        return ProductType(id: id, name: name, price: price)
    }
}
