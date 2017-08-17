//
//  LocalRequest.swift
//  DeliveryAmp
//
//  Created by User on 8/4/17.
//
//

import Foundation
import SwiftyJSON


enum LocalRouter{
    
    //MARK: GET
    case getUser
    case getProducts
    case getServingSizesFood
    case getServingSizesBeverages
    case getProductTypes
    case getIngredients
    case getBeverages
    case getExtras
    case getOrderHistory

    

    
    var requestURL: URL?{
        switch self {
        case .getUser:
            
             guard let documentDirectoryUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
             let fileUrl = documentDirectoryUrl.appendingPathComponent("user.json")
             return fileUrl
 /*
            guard let fileUrl = Bundle.main.url(forResource:"user", withExtension: "json") else { return nil }
            return fileUrl
 */
        case .getProducts:
            guard let fileUrl = Bundle.main.url(forResource:"raw", withExtension: "json") else { return nil }
            return fileUrl
        case .getServingSizesFood:
            guard let fileUrl = Bundle.main.url(forResource:"raw", withExtension: "json") else { return nil }
            return fileUrl
        case .getServingSizesBeverages:
            guard let fileUrl = Bundle.main.url(forResource:"raw", withExtension: "json") else { return nil }
            return fileUrl
        case .getProductTypes:
            guard let fileUrl = Bundle.main.url(forResource:"raw", withExtension: "json") else { return nil }
            return fileUrl
        case .getIngredients:
            guard let fileUrl = Bundle.main.url(forResource:"raw", withExtension: "json") else { return nil }
            return fileUrl
        case .getBeverages:
            guard let fileUrl = Bundle.main.url(forResource:"raw", withExtension: "json") else { return nil }
            return fileUrl
        case .getExtras:
            guard let fileUrl = Bundle.main.url(forResource:"raw", withExtension: "json") else { return nil }
            return fileUrl
        case .getOrderHistory:

            guard let documentDirectoryUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
            let fileUrl = documentDirectoryUrl.appendingPathComponent("order_history.json")
            return fileUrl

         //   guard let fileUrl = Bundle.main.url(forResource:"order_item v2", withExtension: "json") else { return nil }
        //    return fileUrl
 
        default:
            return nil
        }
    }
}

class LocalRequest{
    //GET
    static func generateJSON(for optionalURL: URL?, callback: @escaping (_ result: [String: JSON]?, _ error: Bool) -> ()){
        if let url = optionalURL{
            do {
                let contents = try Data(contentsOf: url)
                let jsonResult = try JSONSerialization.jsonObject(with: contents, options: .mutableContainers)
                if let jsonResponse = JSON(jsonResult).dictionary{
                    callback(jsonResponse, false)
                }else{
                    callback(nil, true)
                }
            } catch {
                callback(nil, true)
            }
        }else{
            callback(nil, true)
        }
    }
    
    static func getUser(_ callback: @escaping(_ user: User?, _ error: String?) -> ()){
        self.generateJSON(for: LocalRouter.getUser.requestURL, callback: {
            (result: [String: JSON]?, failed: Bool) -> Void in
            if failed{
                callback(User(), "Failed to load user.")
            }else if let json = result{
                if let userDict = json["user"]?.dictionary{
                    if let user = User.decode(userDict){
                        callback(user, nil)
                    }
                }else{
                    callback(User(), "Failed to load user.")
                }
            }
        })
    }
    
    static func getProducts(_ callback: @escaping (_ products: [Product]?, _ error: String?) -> ()){
        self.generateJSON(for: LocalRouter.getProducts.requestURL, callback: {
            (result: [String: JSON]?, failed: Bool) -> Void in
            if failed{
                callback(nil, "Failed to load products.")
            }else if let json = result{
                var productsArray: [Product] = []
                if let resultArray = json["products"]?.array{
                    for elem in resultArray{
                        if let productDict = elem.dictionary{
                            if let product = Product.decode(productDict){
                                productsArray.append(product)
                            }
                        }
                    }
                    callback(productsArray, nil)
                }else{
                    callback(nil, "Failed to load products.")
                }
            }
        })
    }
    
    static func getServingSizesFood(_ callback: @escaping (_ servingSizesFood: [ServingSize]?, _ error: String?) -> ()){
        self.generateJSON(for: LocalRouter.getServingSizesFood.requestURL, callback: {
            (result: [String: JSON]?, failed: Bool) -> Void in
            if failed{
                callback(nil, "Failed to load serving sizes for food.")
            }else if let json = result{
                var servingSizesFoodArray: [ServingSize] = []
                if let resultArray = json["serving_sizes_food"]?.array{
                    for elem in resultArray{
                        if let servingSizeDict = elem.dictionary{
                            if let servingSize = ServingSize.decode(servingSizeDict){
                                servingSizesFoodArray.append(servingSize)
                            }
                        }
                    }
                    callback(servingSizesFoodArray, nil)
                }else{
                    callback(nil, "Failed to load serving sizes for food.")
                }
            }
        })
    }
    
    static func getServingSizesBeverages(_ callback: @escaping (_ servingSizesBeverages: [ServingSize]?, _ error: String?) -> ()){
        self.generateJSON(for: LocalRouter.getServingSizesBeverages.requestURL, callback: {
            (result: [String: JSON]?, failed: Bool) -> Void in
            if failed{
                callback(nil, "Failed to load serving sizes for beverages.")
            }else if let json = result{
                var servingSizesBeveragesArray: [ServingSize] = []
                if let resultArray = json["serving_sizes_beverages"]?.array{
                    for elem in resultArray{
                        if let servingSizeDict = elem.dictionary{
                            if let servingSize = ServingSize.decode(servingSizeDict){
                                servingSizesBeveragesArray.append(servingSize)
                            }
                        }
                    }
                    callback(servingSizesBeveragesArray, nil)
                }else{
                    callback(nil, "Failed to load serving sizes for beverages.")
                }
            }
        })
    }
    
    static func getProductTypes(_ callback: @escaping (_ productTypes: [ProductType]?, _ error: String?) -> ()){
        self.generateJSON(for: LocalRouter.getProductTypes.requestURL, callback: {
            (result: [String: JSON]?, failed: Bool) -> Void in
            if failed{
                callback(nil, "Failed to load product types.")
            }else if let json = result{
                var productTypesArray: [ProductType] = []
                if let resultArray = json["product_types"]?.array{
                    for elem in resultArray{
                        if let productTypeDict = elem.dictionary{
                            if let productType = ProductType.decode(productTypeDict){
                                productTypesArray.append(productType)
                            }
                        }
                    }
                    callback(productTypesArray, nil)
                }else{
                    callback(nil, "Failed to load product types")
                }
            }
        })
    }
    
    static func getIngredients(_ callback: @escaping (_ ingredients: [Ingredient]?, _ error: String?) -> ()){
        self.generateJSON(for: LocalRouter.getIngredients.requestURL, callback: {
            (result: [String: JSON]?, failed: Bool) -> Void in
            if failed{
                callback(nil, "Failed to load ingredients.")
            }else if let json = result{
                var ingredientsArray: [Ingredient] = []
                if let resultArray = json["ingredients"]?.array{
                    for elem in resultArray{
                        if let ingredientDict = elem.dictionary{
                            if let ingredient = Ingredient.decode(ingredientDict){
                                ingredientsArray.append(ingredient)
                            }
                        }
                    }
                    callback(ingredientsArray, nil)
                }else{
                    callback(nil, "Failed to load ingredients")
                }
            }
        })
    }
    static func getBeverages(_ callback: @escaping (_ beverages: [Beverage]?, _ error: String?) -> ()){
        self.generateJSON(for: LocalRouter.getBeverages.requestURL, callback: {
            (result: [String: JSON]?, failed: Bool) -> Void in
            if failed{
                callback(nil, "Failed to load extras.")
            }else if let json = result{
                var beveragesArray: [Beverage] = []
                if let resultArray = json["beverages"]?.array{
                    for elem in resultArray{
                        if let beverageDict = elem.dictionary{
                            if let extra = Beverage.decode(beverageDict){
                                beveragesArray.append(extra)
                            }
                        }
                    }
                    callback(beveragesArray, nil)
                }else{
                    callback(nil, "Failed to load extras")
                }
            }
        })
    }
    
    static func getExtras(_ callback: @escaping (_ extras: [Extra]?, _ error: String?) -> ()){
        self.generateJSON(for: LocalRouter.getExtras.requestURL, callback: {
            (result: [String: JSON]?, failed: Bool) -> Void in
            if failed{
                callback(nil, "Failed to load extras.")
            }else if let json = result{
                var extrasArray: [Extra] = []
                if let resultArray = json["extras"]?.array{
                    for elem in resultArray{
                        if let extraDict = elem.dictionary{
                            if let extra = Extra.decode(extraDict){
                                extrasArray.append(extra)
                            }
                        }
                    }
                    callback(extrasArray, nil)
                }else{
                    callback(nil, "Failed to load extras")
                }
            }
        })
    }
    
    
    static func getOrderHistory(_ callback: @escaping (_ orderHistory: [Order]?, _ error: String?) -> ()){
        self.generateJSON(for: LocalRouter.getOrderHistory.requestURL, callback: {
            (result: [String: JSON]?, failed: Bool) -> Void in
            if failed{
                callback(nil, "Failed to load order history.")
            }else if let json = result{
                var ordersArray: [Order] = []
                if let resultArray = json["orders"]?.array{
                    for elem in resultArray{
                        if let orderDict = elem.dictionary{
                            if let order = Order.decode(orderDict){
                                ordersArray.append(order)
                            }
                        }
                    }
                    callback(ordersArray, nil)
                }else{
                    callback(nil, "Failed to load order history")
                }
            }
        })
    }
    
    //POST
    static func postJSON(json: [String:Any], path: String, callback: @escaping (_ result: [String: JSON]?, _ error: Bool) -> ()){
        guard let documentDirectoryUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        let fileUrl = documentDirectoryUrl.appendingPathComponent("\(path).json")
        
        // Transform array into data and save it into file
        do {
            let data = try JSONSerialization.data(withJSONObject: json, options: [])
            try data.write(to: fileUrl, options: [])
            callback(nil, false)
        } catch {
            callback(nil, true)
        }
    }
    
    static func updateUser(user: User, _ callback: @escaping (_ error: String?) -> ()) {
        let userToUpdate = APIRouter.postUpdateUser(user: user).generateBodyParametersForPostUpdateUser(user: user)
        let jsonFormat = ["user": userToUpdate]
        LocalRequest.postJSON(json: jsonFormat, path: "user") { (result, error) in
            if error{
                callback("Failed to post JSON when updating user")
            }else{
                
                callback("postJSON successful when updating user")
            }
        }
        callback("User data updated")
    }
    
    static func postOrderToOrderHistory(order: Order, _ callback: @escaping(_ error: String?) -> ()) {
        let orderToPost = APIRouter.postOrderToOrderHistory(order: order).generateBodyParametersForPostOrderToOrderHistory(order: order)
        var orderHistoryToPost: [[String: Any]] = []
        for oldOrder in orderHistory {
            let oldOrderToPost = APIRouter.postOrderToOrderHistory(order: oldOrder).generateBodyParametersForPostOrderToOrderHistory(order: oldOrder)
            orderHistoryToPost.append(oldOrderToPost)
        }
        orderHistoryToPost.append(orderToPost)
        
        let jsonFormat = ["orders": orderHistoryToPost]
        
        LocalRequest.postJSON(json: jsonFormat, path: "order_history") {
            (result, error) in
            if error{
                callback("Failed to post order history")
            }else{
                orderHistory.append(order)
                callback("Success")
            }
        }
    }
    static func checkOrder () -> Bool {
        if order.items == [] {
            return false
        }
        return true
    }
    
}
