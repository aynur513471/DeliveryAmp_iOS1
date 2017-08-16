//
//  OrderItem.swift
//  DeliveryAmp
//
//  Created by User on 8/10/17.
//
//

import Foundation
import SwiftyJSON

struct OrderItemPropertyKey {
    static let idKey = "id"
    static let typeKey = "type"
    
    static let costKey = "cost"
    static let productKey = "product"
    static let mIngredientsKey = "mIngredients"
    static let productTypeKey = "productType"
    static let servingSizeKey = "servingSize"
    
}

class OrderItem: NSObject {
    
    var id: Int
    var type: Int
    
    var cost: Double
    var product: OrderProduct
    var productType: ProductType
    var servingSize: ServingSize
    var ingredients: [OrderIngredient]
    
    
    
    override init() {
        self.id = -1
        self.type = -1
        self.cost = -1
        self.product = OrderProduct()
        self.productType = ProductType()
        self.servingSize = ServingSize()
        self.ingredients = []
        
    }
    
    init(id: Int, type: Int, cost: Double, product: OrderProduct, productType: ProductType, servingSize: ServingSize, ingredients: [OrderIngredient]) {
        self.id = id
        self.type = type
        self.cost = cost
        self.product = product
        self.productType = productType
        self.servingSize = servingSize
        self.ingredients = ingredients
    }
}

extension OrderItem {
    static func decode(_ json: JSON) -> OrderItem? {
    
        guard let id = json[OrderItemPropertyKey.idKey].int,
            let type = json[OrderItemPropertyKey.typeKey].int,
            let cost = json[OrderItemPropertyKey.costKey].double
            else{
                return nil
        }
        
        
        let product = OrderProduct()
        if let productJSON = json[OrderItemPropertyKey.productKey].dictionary,
            let productDecoded = OrderProduct.decode(productJSON) {
            product.copy(productDecoded)
            print(product)
        }
        
        if type == 0 {
            var ingredients: [OrderIngredient] = []
            if let ingredientsArray = json[OrderItemPropertyKey.mIngredientsKey].array {
                for ingredientJSON in ingredientsArray{
                    if let ingredientDecoded = OrderIngredient.decode(ingredientJSON) {
                        ingredients.append(ingredientDecoded)
                    }
                }
            }
        
            let productType = ProductType()
            if let productTypeJSON = json[OrderItemPropertyKey.productTypeKey].dictionary,
                let productTypeDecoded = ProductType.decode(productTypeJSON) {
                productType.copy(productTypeDecoded)
            }
            
            let servingSize = ServingSize()
            if let servingSizeJSON = json[OrderItemPropertyKey.servingSizeKey].dictionary,
                let servingSizeDecoded = ServingSize.decode(servingSizeJSON) {
                servingSize.copy(servingSizeDecoded)
            }
            
            return OrderItem(id: id, type: type, cost: cost, product: product, productType: productType, servingSize: servingSize, ingredients: ingredients)
        } else if type == 1 {
            let servingSize = ServingSize()
            if let servingSizeJSON = json[OrderItemPropertyKey.servingSizeKey].dictionary,
                let servingSizeDecoded = ServingSize.decode(servingSizeJSON) {
                servingSize.copy(servingSizeDecoded)
                return OrderItem(id: id, type: type, cost: cost, product: product, productType: ProductType(), servingSize: servingSize, ingredients: [])
            }
        }
        return OrderItem(id: id, type: type, cost: cost, product: product, productType: ProductType(), servingSize: ServingSize(), ingredients: [])
    }
}
