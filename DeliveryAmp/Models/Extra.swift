//
//  Extra.swift
//  DeliveryAmp
//
//  Created by User on 8/4/17.
//
//

import Foundation
import Foundation
import SwiftyJSON

struct ExtraPropertyKey {
    static let idKey = "id"
    
    static let nameKey = "name"
    static let extraDescriptionKey = "description"
    static let priceKey = "price"
    static let imageUrlKey = "imageUrl"
    
}

class Extra: NSObject {
    
    var id: Int
    
    var name:String
    var extraDescription: String
    var price: Double
    var imageUrl: String
    
    
    
    override init() {
        self.id = -1
        self.name = ""
        self.extraDescription = ""
        self.price = -1
        self.imageUrl = ""
    }
    
    init(id: Int, name: String, description: String, price: Double, imageUlr: String) {
        self.id = id
        self.name = name
        self.extraDescription = description
        self.price = price
        self.imageUrl = imageUlr
    }
}

extension Extra {
    static func decode(_ json: [String: JSON]) -> Extra? {
        guard let id = json[ExtraPropertyKey.idKey]?.int,
            let name = json[ExtraPropertyKey.nameKey]?.string,
            let extraDescription = json[ExtraPropertyKey.extraDescriptionKey]?.string,
            let price = json[ExtraPropertyKey.priceKey]?.double,
            let imageUrl = json[ExtraPropertyKey.imageUrlKey]?.string
            else{
                return nil
        }
        
        return Extra(id: id, name: name, description: extraDescription, price: price, imageUlr: imageUrl)
    }
}
