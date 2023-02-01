//
//  Utils.swift
//  Spotlight ePOS
//
//  Created by Lu on 30/1/23.
//

import Foundation


struct Utils {
    
    static func calulateHmac(txn_type: String, amount: Int, store_id: String, order_id: String) -> String {
        let zeroPadded = String(format: "%012d", amount)
        let hmacData = txn_type
        + zeroPadded
        + store_id
        + order_id
        
        return hmacData
    }
}
