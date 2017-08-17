//
//  OrderHelper.swift
//  DeliveryAmp
//
//  Created by User on 8/16/17.
//
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
