//
//  PaymentReceipt.swift
//  Spotlight ePOS
//
//  Created by Lu on 30/1/23.
//

import Foundation


class PaymentReceipt: Codable {
    let txnType, storeID, posID, userID: String
    let orderID: String
    let amount: Int
    var paymentPlan, digest: String
    
    enum CodingKeys: String, CodingKey {
        case txnType = "txn_type"
        case storeID = "store_id"
        case posID = "pos_id"
        case userID = "user_id"
        case orderID = "order_id"
        case amount
        case paymentPlan = "payment_plan"
        case digest
    }
    
    init(_ order: Order) {
        txnType = "020000"
        storeID = "4001"
        posID = "01"
        userID = "XC01"
        orderID = order.orderId
        amount = order.amount
        paymentPlan = "0100"
        digest = ""
    }
}
