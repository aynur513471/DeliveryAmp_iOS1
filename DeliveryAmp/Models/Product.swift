//
//  File.swift
//  DeliveryAmp
//
//  Created by User on 8/4/17.
//
//

import Foundation
import SwiftyJSON

struct ProductPropertyKey {
    static let idKey = "id"
    
    static let nameKey = "name"
    static let productDescriptionKey = "description"
    static let priceKey = "price"
    static let sizeIdsKey = "sizesId"
    static let crustIdsKey = "crustsId"
    static let imageUrlKey = "imageUrl"
    static let ingredientIdsKey = "ingredientIds"
    
}

class Product: NSObject {
    
    var id: Int
    
    var name:String
    var productDescription: String
    var price: Double
    var sizeIds: [Int]
    var crustIds: [Int]
    var imageUrl: String
    var ingredientIds: [Int]
    
    
    override init() {
        self.id = -1
        self.name = ""
        self.productDescription = ""
        self.price = -1
        self.sizeIds = []
        self.crustIds = []
        self.imageUrl = ""
        self.ingredientIds = []
    }
    
    init(id: Int, name: String, description: String, price: Double, sizeIds: [Int], crustIds: [Int], imageUlr: String, ingredientIds: [Int]) {
        self.id = id
        self.name = name
        self.productDescription = description
        self.price = price
        self.sizeIds = sizeIds
        self.crustIds = crustIds
        self.imageUrl = imageUlr
        self.ingredientIds = ingredientIds
    }
}

extension Product {
    static func decode(_ json: [String: JSON]) -> Product? {
        
        var sizeIds: [Int] = []
        if let sizeIdsArray = json[ProductPropertyKey.sizeIdsKey]?.array {
            sizeIds = sizeIdsArray.map {$0.int!}
        }
        
        var crustIds: [Int] = []
        if let crustIdsArray = json[ProductPropertyKey.crustIdsKey]?.array {
            crustIds = crustIdsArray.map{$0.int!}
        }
        
        var ingredientIds: [Int] = []
        if let ingredientIdsArray = json[ProductPropertyKey.ingredientIdsKey]?.array {
            ingredientIds = ingredientIdsArray.map{$0.int!}
        }
           
        guard let id = json[ProductPropertyKey.idKey]?.int,
            let name = json[ProductPropertyKey.nameKey]?.string,
            let productDescription = json[ProductPropertyKey.productDescriptionKey]?.string,
            let price = json[ProductPropertyKey.priceKey]?.double,
            let imageUrl = json[ProductPropertyKey.imageUrlKey]?.string
            else{
                return nil
        }
        
        return Product(id: id, name: name, description: productDescription, price: price, sizeIds: sizeIds, crustIds: crustIds, imageUlr: imageUrl, ingredientIds: ingredientIds)
    }
}
