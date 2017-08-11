//
//  APIRouter.swift
//  DeliveryAmp
//
//  Created by User on 8/11/17.
//
//

import Foundation


enum APIRouter{
    
    
    //MARK: POST
    case updateUser(user: User)

    
    /*
    
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
    
    var requestPath: String{
        switch self{
        case .getProducts:
            return "products" //path to products
        case .getUserByID, .postLoginWithEmail, .postUpdateUser, .getUsers, .getUserByEmail, .postPasswordRecovery:
            return "users" //path to users
        case .getCartList, .postCartList:
            return "cart" //path to cart
        case .getWishList, .postWishList, .removeCartProduct:
            return "wishlist" //path to wishlist
        case .postOrder:
            return "order" //path to order
        }
    }
    */
    
    
    //MARK: Header Parameters
    /*
    var headerParameters: HeaderParameters{
        switch self {
        case let .updateUser():
            return generateHeaderParametersForUpdateUser()
        default:
            return HeaderParameters()
        }
    }
    
    
    //MARK: Body Parameters
    var bodyParameters: BodyParameters {
        switch self {
        case let .updateUser(user):
            return generateBodyParametersForUpdateUser(user: user)
        default:
            return BodyParameters()
        }
    }
 */
    
}
