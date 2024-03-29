//
//  File.swift
//  DeliveryAmp
//
//  Copyright © 2017 ThemeDimension.com
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
    
    init(id: Int, name: String, description: String, price: Double, sizeIds: [Int], crustIds: [Int], imageUrl: String, ingredientIds: [Int]) {
        self.id = id
        self.name = name
        self.productDescription = description
        self.price = price
        self.sizeIds = sizeIds
        self.crustIds = crustIds
        self.imageUrl = imageUrl
        self.ingredientIds = ingredientIds
    }
    
    func copy(_ product: Product) {
        self.id = product.id
        self.name = product.name
        self.productDescription = product.productDescription
        self.price = product.price
        self.sizeIds = product.sizeIds
        self.crustIds = product.crustIds
        self.imageUrl = product.imageUrl
        self.ingredientIds = product.ingredientIds
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
        
        return Product(id: id, name: name, description: productDescription, price: price, sizeIds: sizeIds, crustIds: crustIds, imageUrl: imageUrl, ingredientIds: ingredientIds)
    }
}
