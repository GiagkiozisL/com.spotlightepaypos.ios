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

    }
    
    
    func invokeCrypto() async {
        let md5 = await CryptoAnalyzer.shared.analyze("mpoumpounito")
        print("controller says md5: \(md5)")
    }
    
    
    //        Crypto()
    // Do any additional setup after loading the view.
    
    //        var proximityHepler = ProximityHelper()
    
    //        let txnType = "020000"
    //        let amount = 4599
    //        let storeId = "4001"
    //        let orderId = "467eecc6-e3ac-4dc7-9418-e038d3491f79"
    //        let secret = calulateHmac(txn_type: txnType, amount: amount, store_id: storeId, order_id: orderId)
    
//    let key = "VerySecret"
//    let msg = "0200000000000045994001467eecc6-e3ac-4dc7-9418-e038d3491f79"
//    print("do hmac1: \(doHmac(key: key, msg: msg))")
//    print("do hmac2: \(doHmac(key: key.MD5, msg: msg))")
//    let bytes: Array<UInt8> = key.bytes
//    let digest = Digest.md5(bytes)
//    print("do hmac3: \(doHmac(key: digest.toHexString(), msg: msg))")
//    print("do hmac4: \(mac(secretKey: digest.toHexString(), message: msg))")
//    //
//
//    func mac(secretKey: String, message: String) -> String {
//        let digestLength = Int(CC_SHA256_DIGEST_LENGTH)
//        let mac = UnsafeMutablePointer<CChar>.allocate(capacity: digestLength)
//
//        let cSecretKey: [CChar]? = secretKey.cString(using: .utf8)
//        let cSecretKeyLength = secretKey.lengthOfBytes(using: .utf8)
//
//        let cMessage: [CChar]? = message.cString(using: .utf8)
//        let cMessageLength = message.lengthOfBytes(using: .utf8)
//
//        CCHmac(CCHmacAlgorithm(kCCHmacAlgSHA256), cSecretKey, cSecretKeyLength, cMessage, cMessageLength, mac)
//
//        let macData = Data(bytes: mac, count: digestLength)
//
//        return macData.base64EncodedString()
//    }
//
//    func calulateHmac(txn_type: String, amount: Int, store_id: String, order_id: String) -> String {
//        let zeroPadded = String(format: "%012d", amount)
//        let hmacData = txn_type
//        + zeroPadded
//        + store_id
//        + order_id
//
//        print("zeroPadded: \(zeroPadded)")
//        print("hmac: \(hmacData)")
//
//        let key = "VerySecret".MD5
//        print("md5: \(key)")
//        let secret = doHmac(key: key, msg: hmacData)
//        let secret2 = mac(secretKey: key, message: hmacData)
//
//        print("secret is: \(secret)")
//        print("secret2 is: \(secret2)")
//
//        let expecrtedHmac = "1b44b30ae15eb7ec5e77f723643dd8c4db22070d62db755aeb585acce495f35d"
//        print("there is match: \(expecrtedHmac == secret)")
//        return secret
//    }
//
//    func doHmac(key: String, msg: String) -> String {
//        do {
//            let hmacBts = try CryptoSwift.HMAC(key: key, variant: .sha256).authenticate(msg.bytes)
//            let data = Data(hmacBts)
//            return data.toHexString()
//        } catch {
//            print("Hash computation failed")
//        }
//        return ""
//    }
//
//
//    func convert64EncodedToHex(_ data:Data) -> String {
//        return data.map{ String(format: "%02x", $0) }.joined()
//    }
//
//    // CommonCrypto HMAC SHA256
//    //    func mac(secretKey: String, message: String) -> String {
//    //        let digestLength = Int(CC_SHA256_DIGEST_LENGTH)
//    //        let mac = UnsafeMutablePointer<CChar>.allocate(capacity: digestLength)
//    //
//    //        let cSecretKey: [CChar]? = secretKey.cString(using: .utf8)
//    //        let cSecretKeyLength = secretKey.lengthOfBytes(using: .utf8)
//    //
//    //        let cMessage: [CChar]? = message.cString(using: .utf8)
//    //        let cMessageLength = message.lengthOfBytes(using: .utf8)
//    //
//    //        CCHmac(CCHmacAlgorithm(kCCHmacAlgSHA256), cSecretKey, cSecretKeyLength, cMessage, cMessageLength, mac)
//    //
//    //        let data = Data(bytes: mac, count: digestLength)
//    //
//    //        return convert64EncodedToHex(data)// macData.base64EncodedString()
//    //    }
//
    
}
