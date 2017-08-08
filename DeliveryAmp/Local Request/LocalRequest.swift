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
    case getProducts
    case getServingSizesFood
    case getServingSizesBeverages
    case getProductTypes
    case getIngredients
    case getBeverages
    case getExtras
    

    
    var requestURL: URL?{
        switch self {
        case .getProducts:
            guard let documentDirectoryUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
            let fileUrl = documentDirectoryUrl.appendingPathComponent("raw.json")
            return fileUrl
        case .getServingSizesFood:
            guard let documentDirectoryUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
            let fileUrl = documentDirectoryUrl.appendingPathComponent("raw.json")
            return fileUrl
        case .getServingSizesBeverages:
            guard let documentDirectoryUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
            let fileUrl = documentDirectoryUrl.appendingPathComponent("raw.json")
            return fileUrl
        case .getProductTypes:
            guard let documentDirectoryUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
            let fileUrl = documentDirectoryUrl.appendingPathComponent("raw.json")
            return fileUrl
        case .getIngredients:
            guard let documentDirectoryUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
            let fileUrl = documentDirectoryUrl.appendingPathComponent("raw.json")
            return fileUrl
        case .getBeverages:
            guard let documentDirectoryUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
            let fileUrl = documentDirectoryUrl.appendingPathComponent("raw.json")
            return fileUrl
        case .getExtras:
            guard let documentDirectoryUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
            let fileUrl = documentDirectoryUrl.appendingPathComponent("raw.json")
            return fileUrl
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
                        if let ingredientTypeDict = elem.dictionary{
                            if let ingredient = Ingredient.decode(ingredientTypeDict){
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
                        if let beverageTypeDict = elem.dictionary{
                            if let extra = Beverage.decode(beverageTypeDict){
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
                        if let extraTypeDict = elem.dictionary{
                            if let extra = Extra.decode(extraTypeDict){
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
    
    
    
}
