//
//  APIRequest.swift
//  DeliveryAmp
//
//  Copyright © 2017 ThemeDimension.com
//

import Alamofire
import Foundation
import SwiftyJSON


//MARK: GET Requests
class APIRequest{
    
    
    //basic get function
    static func generateJSON(
        for path: String,
        parameters: HeaderParameters = [:],
        callback:@escaping (_ result: [String: JSON], _ error: Bool) -> ()
        ){
        if let url = URL(string: path){
            for elem in parameters{
                APIRouter.headers.updateValue(elem.value, forKey: elem.key)
            }
            let headers = APIRouter.headers
            Alamofire.request(url, parameters: parameters, headers: headers)
                .responseJSON{
                    response in
                    switch response.result{
                    case .failure(let error):
                        callback(JSON(error).dictionary ?? [:], true)
                    case .success(let value):
                        if let responseDictionary = JSON(value).dictionary,
                            let status = responseDictionary["status"]?.int{
                            if status == 1 {
                                callback(responseDictionary, false)
                            }else{
                                callback(responseDictionary, true)
                            }
                        }else{
                            callback(JSON(value).dictionary ?? [:], true)
                        }
                    }
            }
        }
    }
    
    //Get all products
    static func getProducts(_ callback: @escaping (_ products: [Product]?, _ error: String?) -> ()){
        self.generateJSON(for: APIRouter.getProducts.path, callback: {
            (result: [String: JSON], failed: Bool) -> Void in
            if failed{
                callback(nil, "Failed")
            }else{
                var productsArray: [Product] = []
                if let resultArray = result["products"]?.array{
                    for elem in resultArray{
                        if let productDict = elem.dictionary{
                            if let product = Product.decode(productDict){
                                productsArray.append(product)
                            }
                        }
                    }
                    callback(productsArray, nil)
                }else{
                    callback(nil, "Failed")
                }
                
            }
        })
    }
    
    //Get all beverages
    static func getBeverages(_ callback: @escaping (_ beverages: [Beverage]?, _ error: String?) -> ()){
        self.generateJSON(for: APIRouter.getBeverages.path, callback: {
            (result: [String: JSON], failed: Bool) -> Void in
            if failed{
                callback(nil, "Failed")
            }else{
                var beveragesArray: [Beverage] = []
                if let resultArray = result["beverages"]?.array{
                    for elem in resultArray{
                        if let beverageDict = elem.dictionary{
                            if let beverage = Beverage.decode(beverageDict){
                                beveragesArray.append(beverage)
                            }
                        }
                    }
                    callback(beveragesArray, nil)
                }else{
                    callback(nil, "Failed")
                }
                
            }
        })
    }
    
    //Get all extras
    static func getExtras(_ callback: @escaping (_ extras: [Extra]?, _ error: String?) -> ()){
        self.generateJSON(for: APIRouter.getExtras.path, callback: {
            (result: [String: JSON], failed: Bool) -> Void in
            if failed{
                callback(nil, "Failed")
            }else{
                var extrasArray: [Extra] = []
                if let resultArray = result["extras"]?.array{
                    for elem in resultArray{
                        if let extraDict = elem.dictionary{
                            if let extra = Extra.decode(extraDict){
                                extrasArray.append(extra)
                            }
                        }
                    }
                    callback(extrasArray, nil)
                }else{
                    callback(nil, "Failed")
                }
                
            }
        })
    }
    
    //Get all serving sizes for food
    static func getServingSizesFood(_ callback: @escaping (_ servingSizesFood: [ServingSize]?, _ error: String?) -> ()){
        self.generateJSON(for: APIRouter.getServingSizesFood.path, callback: {
            (result: [String: JSON], failed: Bool) -> Void in
            if failed{
                callback(nil, "Failed")
            }else{
                var servingSizesArray: [ServingSize] = []
                if let resultArray = result["serving_sizes_food"]?.array{
                    for elem in resultArray{
                        if let servingSizeDict = elem.dictionary{
                            if let servingSize = ServingSize.decode(servingSizeDict){
                                servingSizesArray.append(servingSize)
                            }
                        }
                    }
                    callback(servingSizesArray, nil)
                }else{
                    callback(nil, "Failed")
                }
                
            }
        })
    }
    
    //Get all serving sizes for beverages
    static func getServingSizesBeverages(_ callback: @escaping (_ servingSizesBeverages: [ServingSize]?, _ error: String?) -> ()){
        self.generateJSON(for: APIRouter.getServingSizesBeverages.path, callback: {
            (result: [String: JSON], failed: Bool) -> Void in
            if failed{
                callback(nil, "Failed")
            }else{
                var servingSizesArray: [ServingSize] = []
                if let resultArray = result["serving_sizes_beverages"]?.array{
                    for elem in resultArray{
                        if let servingSizeDict = elem.dictionary{
                            if let servingSize = ServingSize.decode(servingSizeDict){
                                servingSizesArray.append(servingSize)
                            }
                        }
                    }
                    callback(servingSizesArray, nil)
                }else{
                    callback(nil, "Failed")
                }
                
            }
        })
    }
    
    //Get all product types
    static func getProductTypes(_ callback: @escaping (_ produtcTypes: [ProductType]?, _ error: String?) -> ()){
        self.generateJSON(for: APIRouter.getProductTypes.path, callback: {
            (result: [String: JSON], failed: Bool) -> Void in
            if failed{
                callback(nil, "Failed")
            }else{
                var productTypesArray: [ProductType] = []
                if let resultArray = result["product_types"]?.array{
                    for elem in resultArray{
                        if let productTypeDict = elem.dictionary{
                            if let productType = ProductType.decode(productTypeDict){
                                productTypesArray.append(productType)
                            }
                        }
                    }
                    callback(productTypesArray, nil)
                }else{
                    callback(nil, "Failed")
                }
                
            }
        })
    }
    
    //Get all ingredients
    static func getIngredients(_ callback: @escaping (_ ingredients: [Ingredient]?, _ error: String?) -> ()){
        self.generateJSON(for: APIRouter.getIngredients.path, callback: {
            (result: [String: JSON], failed: Bool) -> Void in
            if failed{
                callback(nil, "Failed")
            }else{
                var ingredientsArray: [Ingredient] = []
                if let resultArray = result["ingredients"]?.array{
                    for elem in resultArray{
                        if let ingredientDict = elem.dictionary{
                            if let ingredient = Ingredient.decode(ingredientDict){
                                ingredientsArray.append(ingredient)
                            }
                        }
                    }
                    callback(ingredientsArray, nil)
                }else{
                    callback(nil, "Failed")
                }
                
            }
        })
    }
    
    //Get order history
    static func getOrderHistory(_ callback: @escaping (_ orderHistory: [Order]?, _ error: String?) -> ()){
        let router = APIRouter.getOrderHistory(user: CurrentUser.sharedInstance)
        self.generateJSON(for: router.path, parameters: router.headerParameters, callback: {
            (result: [String: JSON], failed: Bool) -> Void in
            if failed{
                callback(nil, "Failed")
            }else{
                var ordersArray: [Order] = []
                if let resultArray = result["orders"]?.array{
                    for elem in resultArray{
                        if let orderDict = elem.dictionary{
                            if let order = Order.decode(orderDict){
                                ordersArray.append(order)
                            }
                        }
                    }
                    callback(ordersArray, nil)
                }else{
                    callback(nil, "Failed")
                }
                
            }
        })
    }
    
    
    
    
    

    
    
}

//MARK: POST Requests
extension APIRequest{
    
    
    //basic post function
    static func generatePostJSON(
        for path: String,
        parameters: BodyParameters = [:],
        callback:@escaping (_ result: [String: JSON], _ error: Bool) -> ()
        ){
        if let url = URL(string: path){
            Alamofire.request(url, method: .post, parameters: parameters, headers: APIRouter.headers)
                .responseJSON{
                    response in
                    switch response.result{
                    case .failure(let error):
                        callback(JSON(error).dictionary ?? [:], true)
                    case .success(let value):
                        if let responseDictionary = JSON(value).dictionary,
                            let status = responseDictionary["status"]?.int{
                            if status == 1 {
                                callback(responseDictionary, false)
                            }else{
                                callback(responseDictionary, true)
                            }
                        }else{
                            callback(JSON(value).dictionary ?? [:], true)
                        }
                    }
            }
        }
    }
    
    static func postUpdateUser(user: User,  _ callback: @escaping (_ error: String?) -> ()){
        let router = APIRouter.postUpdateUser(user: user)
        
        self.generatePostJSON(for: router.path,
                              parameters: router.bodyParameters,
                              callback: {
                                (result: [String: JSON], failed: Bool) -> Void in
                                if failed{
                                    if let resultDict = result["response"]?.dictionary, let resultError = ServerError.decode(resultDict){
                                        callback(resultError.message)
                                    }else{
                                        if Reachability.isConnectedToNetwork() {
                                            callback("Failed.")
                                        } else {
                                            callback("No internet connection.")
                                        }
                                    }
                                }else{
                                    if let resultDictionary = result["response"]?.dictionary{
                                        if let _ = User.decode(resultDictionary){
                                            callback(nil)
                                            
                                        }
                                        
                                    }else{
                                        callback("Failed")
                                    }
                                    
                                }
        })
    }
    
    static func postOrderToOrderHistory(order: Order,  _ callback: @escaping (_ error: String?) -> ()){
        let router = APIRouter.postOrderToOrderHistory(order: order)
        
        self.generatePostJSON(for: router.path,
                              parameters: router.bodyParameters,
                              callback: {
                                (result: [String: JSON], failed: Bool) -> Void in
                                if failed{
                                    if let resultDict = result["response"]?.dictionary, let resultError = ServerError.decode(resultDict){
                                        callback(resultError.message)
                                    }else{
                                        if Reachability.isConnectedToNetwork() {
                                            callback("Failed.")
                                        } else {
                                            callback("No internet connection.")
                                        }
                                    }
                                }else{
                                    if let resultDictionary = result["response"]?.dictionary{
                                        if let _ = Order.decode(resultDictionary){
                                            callback(nil)
                                            
                                        }
                                        
                                    }else{
                                        callback("Failed")
                                    }
                                    
                                }
        })
    }
    

    
    
}
