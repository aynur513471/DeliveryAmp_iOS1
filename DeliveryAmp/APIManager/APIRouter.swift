//
//  APIRouter.swift
//  DeliveryAmp
//
//  Copyright © 2017 ThemeDimension.com
//

import Foundation
import Alamofire

enum APIRouter{
    
    
    //MARK: - GET
    
    case getProducts
    case getServingSizesFood
    case getServingSizesBeverages
    case getProductTypes
    case getIngredients
    case getBeverages
    case getExtras
    case getOrderHistory(user: User)
    
    
    //MARK: - POST
    case postUpdateUser(user: User)
    case postOrderToOrderHistory(order: Order)

    
    
    
    //MARK: Header
    static var headers: HTTPHeaders =
        ["apikey": "12345678910"] //enter your api key here
    
    
    //MARK: Base Path
    static var basePath: String{
        return "https://api.example/" //enter your base path request api here
    }
    
    //MARK: Final Path
    var path: String{
        return APIRouter.basePath + requestPath
    }

    // REQUEST PATH
    var requestPath: String{
        switch self{
        case .getProducts:
            return "products" //path to products
        case .getServingSizesFood:
            return "servingSizesFood"
        case .getServingSizesBeverages:
            return "servingSizesBeverages"
        case .getProductTypes:
            return "productTypes"
        case .getIngredients:
            return "ingredients"
        case .getBeverages:
            return "beverages"
        case .getExtras:
            return "extras"
        case .getOrderHistory:
            return "order_history" //path to order history
        default:
            return ""
        }
    }

    //MARK: Header Parameters
    var headerParameters: HeaderParameters{
        
        switch self {
            /*
        case let .getProducts():
            return generateHeaderParametersForGetProducts()
        case let .getServingSizesFood():
            return generateHeaderParametersForGetProducts()
        case let .getServingSizesBeverages():
            return generateHeaderParametersForGetProducts()
        case let .getProductTypes():
            return generateHeaderParametersForGetProducts()
        case let .getIngredients():
            return generateHeaderParametersForGetProducts()
        case let .getBeverages():
            return generateHeaderParametersForGetProducts()
        case let .getExtras():
            return generateHeaderParametersForGetProducts()
             */
        case let .getOrderHistory(user: user):
            return generateHeaderParametersForGetOrderHistory(user: user)

        default:
            return HeaderParameters()
        }
    }
    
    //MARK: Body Parameters
    var bodyParameters: BodyParameters {
        switch self {
        case let .postUpdateUser(user: user):
            return generateBodyParametersForPostUpdateUser(user: user)
        case let .postOrderToOrderHistory(order: order):
            return generateBodyParametersForPostOrderToOrderHistory(order: order)
        default:
            return BodyParameters()
        }
    }
 
    
}
