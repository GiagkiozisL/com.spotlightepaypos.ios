//
//  Data.swift
//  Spotlight ePOS
//
//  Created by Lu on 19/1/23.
//

import Foundation
import CryptoKit
import CommonCrypto
import CryptoSwift


extension Data {
    var md5 : String {
        var digest = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
        _ =  self.withUnsafeBytes { bytes in
            CC_MD5(bytes, CC_LONG(self.count), &digest)
        }
        var digestHex = ""
        for index in 0..<Int(CC_MD5_DIGEST_LENGTH) {
            digestHex += String(format: "%02x", digest[index])
        }
        return digestHex
    }
    
    var array: [UInt8] { return Array(self) }

}
