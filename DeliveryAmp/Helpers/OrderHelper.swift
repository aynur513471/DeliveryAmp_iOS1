//
//  OrderHelper.swift
//  DeliveryAmp
//
//  Copyright © 2017 ThemeDimension.com
//

import Foundation


class OrderHelper {
    
    static func getNextOrderId() -> Int {
        var idNotUsed: Bool = false
        //orderItemId = 0
        while !idNotUsed {
            idNotUsed = true
            orderItemId += 1
            for item in order.items {
                if item.id == orderItemId {
                    idNotUsed = false
                }
            }
        }
        return orderItemId
    }

}
