//
//  Beverage.swift
//  DeliveryAmp
//
//  Created by User on 8/4/17.
//
//

import Foundation
import SwiftyJSON

struct BeveragePropertyKey {
    static let idKey = "id"    
    static let nameKey = "name"
    static let beverageDescriptionKey = "description"
    static let priceKey = "price"
    static let sizeIdsKey = "sizesId"
    static let imageUrlKey = "imageUrl"
    
}

class Beverage: NSObject {
    
    var id: Int
    
    var name:String
    var beverageDescription: String
    var price: Double
    var sizeIds: [Int]
    var imageUrl: String

    override init() {
        self.id = -1
        self.name = ""
        self.beverageDescription = ""
        self.price = -1
        self.sizeIds = []
        self.imageUrl = ""
    }
    
    init(id: Int, name: String, description: String, price: Double, sizeIds: [Int], imageUlr: String) {
        self.id = id
        self.name = name
        self.beverageDescription = description
        self.price = price
        self.sizeIds = sizeIds
        self.imageUrl = imageUlr
    }
    
    func copy(_ beverage: Beverage) {
        self.id = beverage.id
        self.name = beverage.name
        self.beverageDescription = beverage.beverageDescription
        self.price = beverage.price
        self.sizeIds = beverage.sizeIds
        self.imageUrl = beverage.imageUrl
    }
}

extension Beverage {
    static func decode(_ json: [String: JSON]) -> Beverage? {
        
        var sizeIds: [Int] = []
        if let sizeIdsArray = json[BeveragePropertyKey.sizeIdsKey]?.array {
            sizeIds = sizeIdsArray.map {$0.int!}
        }
        
        guard let id = json[BeveragePropertyKey.idKey]?.int,
            let name = json[BeveragePropertyKey.nameKey]?.string,
            let beverageDescription = json[BeveragePropertyKey.beverageDescriptionKey]?.string,
            let price = json[BeveragePropertyKey.priceKey]?.double,
            let imageUrl = json[BeveragePropertyKey.imageUrlKey]?.string
            else{
                return nil
        }
        
        return Beverage(id: id, name: name, description: beverageDescription, price: price, sizeIds: sizeIds, imageUlr: imageUrl)
    }
}
