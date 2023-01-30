//
//  Order.swift
//  Spotlight ePOS
//
//  Created by Lu on 30/1/23.
//

import Foundation

struct Order : Codable {
    
    var orderId: String = ""
    var amount: Int = 0
    var storeId: String = ""
    var key: String = ""
    
    init() {
        amount = 245
    }
    
    
}
