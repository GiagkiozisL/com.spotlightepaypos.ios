//
//  ViewController.swift
//  Spotlight ePOS
//
//  Created by Lu on 17/1/23.
//

import UIKit
import UIKit
import ProximityReader
import CryptoKit
import CryptoSwift
import CommonCrypto
import WebKit

import zlib


class ViewController: UIViewController {
    
    let server_key = "AQEyhmfuXNWTK0Qc+iSDgmssq+2cQJ99IqBiXWlax2ubvTAazOe8b/FQbjuLbEhrxjINpPUQwV1bDb7kfNy1WIxIIkxgBw==-cj4dyNHIAGurMhJLX4Hduh3YgH4g5hIJyk5JsY7Wz7g=-2bvJ+AuX5u9zWX#T"
    let clientKey = "test_WJXNXPHWN5FD3DVJCELWOJILOYPQDJ7K"
    
    var reader: PaymentCardReader?
    var webView: WKWebView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        constructHmac()
    }
    
    func constructHmac() {
        
        let txnType = "020000"
        let amount = 4599
        let storeId = "4001"
        let orderId = "467eecc6-e3ac-4dc7-9418-e038d3491f79"
        let message = calulateHmac(txn_type: txnType, amount: amount, store_id: storeId, order_id: orderId)
        let key = "VerySecret"
        
        // test js hmac hash
        Task {
            print("message is a match \(message == "0200000000000045994001467eecc6-e3ac-4dc7-9418-e038d3491f79")")
            let hash = await CryptoAnalyzer.shared.analyze("0200000000000045994001467eecc6-e3ac-4dc7-9418-e038d3491f79", "VerySecret")
            print("hmac::: \(hash)")
            print("hash is a match \(hash == "1b44b30ae15eb7ec5e77f723643dd8c4db22070d62db755aeb585acce495f35d")")
        }
    }
    
    func calulateHmac(txn_type: String, amount: Int, store_id: String, order_id: String) -> String {
        let zeroPadded = String(format: "%012d", amount)
        let hmacData = txn_type
        + zeroPadded
        + store_id
        + order_id
        
        return hmacData
    }
}
