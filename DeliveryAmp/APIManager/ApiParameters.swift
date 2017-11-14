//
//  ApiParameters.swift
//  DeliveryAmp
//
//  Copyright © 2017 ThemeDimension.com
//

import Foundation
import SwiftyJSON
import UIKit

typealias BodyParameters = [String: Any]
typealias HeaderParameters = [String: String]

extension APIRouter{
    
    //MARK: GET
    

    //get order history
    func generateHeaderParametersForGetOrderHistory(user: User) -> HeaderParameters{
        let parameters: HeaderParameters = ["user": user.email]
 
        return parameters
    }
    
    
    //MARK: POST

    //update user
    func generateBodyParametersForPostUpdateUser(user: User) -> BodyParameters {
        
        var parameters: BodyParameters = [:]
        parameters["action"] = "update"
        
        var creditCard: BodyParameters = [:]
        
        if DEMO_DATA || CurrentUser.sharedInstance.firstName != user.firstName {
            parameters[UserPropertyKey.firstNameKey] = user.firstName
        }
        
        if DEMO_DATA || CurrentUser.sharedInstance.lastName != user.lastName {
            parameters[UserPropertyKey.lastNameKey] = user.lastName
        }
        
        if DEMO_DATA || CurrentUser.sharedInstance.phone != user.phone {
            parameters[UserPropertyKey.phoneKey] = user.phone
        }
        
        if DEMO_DATA || CurrentUser.sharedInstance.email != user.email {
            parameters[UserPropertyKey.emailKey] = user.email
        }
        
        if DEMO_DATA || CurrentUser.sharedInstance.address != user.address {
            parameters[UserPropertyKey.addressKey] = user.address
        }
        
        if DEMO_DATA || CurrentUser.sharedInstance.creditCard.cardNumber != user.creditCard.cardNumber {
            creditCard[CreditCardPropertyKey.cardNumberKey] = user.creditCard.cardNumber
        }
        
        if DEMO_DATA || CurrentUser.sharedInstance.creditCard.cardHolder != user.creditCard.cardHolder {
            creditCard[CreditCardPropertyKey.cardHolderKey] = user.creditCard.cardHolder
        }
        
        if DEMO_DATA || CurrentUser.sharedInstance.creditCard.csvCode != user.creditCard.csvCode {
            creditCard[CreditCardPropertyKey.csvCodeKey] = user.creditCard.csvCode
        }
        
        if DEMO_DATA || CurrentUser.sharedInstance.creditCard.expYear != user.creditCard.expYear {
            creditCard[CreditCardPropertyKey.expYearKey] = user.creditCard.expYear
        }
        
        if DEMO_DATA || CurrentUser.sharedInstance.creditCard.expMonth != user.creditCard.expMonth {
            creditCard[CreditCardPropertyKey.expMonthKey] = user.creditCard.expMonth
        }
        
        parameters[UserPropertyKey.creditCardKey] = creditCard
        
        return parameters
    }
    
    //update order history
    func generateBodyParametersForPostOrderToOrderHistory(order: Order) -> BodyParameters {
        var itemsParameters: [BodyParameters] = []
        for item in order.items {
            let productParameters: BodyParameters =
            [
                OrderProductPropertyKey.idKey: item.product.id,
                OrderProductPropertyKey.nameKey: item.product.name,
                OrderProductPropertyKey.priceKey: item.product.price
            ]
            
            let productTypeParameters: BodyParameters =
            [
                ProductTypePropertyKey.idKey: item.productType.id,
                ProductTypePropertyKey.nameKey: item.productType.name,
                ProductTypePropertyKey.priceKey: item.productType.price
            ]
            
            let servingSizeParameters: BodyParameters =
            [
                ServingSizePropertyKey.idKey: item.servingSize.id,
                ServingSizePropertyKey.nameKey: item.servingSize.name,
                ServingSizePropertyKey.priceKey: item.servingSize.price,
                ServingSizePropertyKey.quantityKey: item.servingSize.quantity
            ]
            
            var ingredientsParameters: [BodyParameters] = []
            for ingredient in item.ingredients {
                ingredientsParameters.append([
                    OrderIngredientPropertyKey.idKey: ingredient.id,
                    OrderIngredientPropertyKey.costKey: ingredient.cost,
                    OrderIngredientPropertyKey.nameKey: ingredient.name,
                    OrderIngredientPropertyKey.quantityKey: ingredient.quantity
                    ])
            }
            
            itemsParameters.append([
                OrderItemPropertyKey.typeKey: item.type,
                OrderItemPropertyKey.idKey: item.id,
                OrderItemPropertyKey.costKey: item.cost,
                OrderItemPropertyKey.productKey: productParameters,
                OrderItemPropertyKey.mIngredientsKey: ingredientsParameters,
                OrderItemPropertyKey.productTypeKey: productTypeParameters,
                OrderItemPropertyKey.servingSizeKey: servingSizeParameters
                ])
            
        }
        
        let parameters: BodyParameters =
            [
             OrderPropertyKey.addressKey: order.address,
             OrderPropertyKey.dateKey: order.date,
             OrderPropertyKey.deliveryDetailsHadChangedKey: order.deliveryDetailsHadChanged,
             OrderPropertyKey.emailKey: order.email,
             OrderPropertyKey.firstNameKey: order.firstName,
             OrderPropertyKey.lastNameKey: order.lastName,
             OrderPropertyKey.phoneKey: order.phone,
             OrderPropertyKey.orderHasItemsKey: order.orderHasItems,
             OrderPropertyKey.totalCostKey: order.totalCost,
             OrderPropertyKey.itemsKey: itemsParameters
        ]
        
        return parameters
    }

 }
