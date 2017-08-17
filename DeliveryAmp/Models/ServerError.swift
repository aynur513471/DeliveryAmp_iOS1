//
//  File.swift
//  DeliveryAmp
//
//  Created by User on 8/14/17.
//
//

import Foundation
import SwiftyJSON

struct ServerErrorPropertyKey{
    static let codeKey = "err_code"
    static let messageKey = "err_msg"
}

struct ServerError{
    var code: Int
    var message: String
    
    static func decode(_ json: [String: JSON]) -> ServerError?{
        
        guard let code = json[ServerErrorPropertyKey.codeKey]?.int,
            let message = json[ServerErrorPropertyKey.messageKey]?.string
            else{
                return nil
        }
        
        return ServerError(
            code: code,
            message: message
        )
    }
    
}
