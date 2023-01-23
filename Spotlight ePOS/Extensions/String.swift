//
//  String.swift
//  Spotlight ePOS
//
//  Created by Lu on 19/1/23.
//

import Foundation
import CryptoKit
import CommonCrypto
import CryptoSwift


extension String {
    var MD5: String {
        let computed = Insecure.MD5.hash(data: self.data(using: .utf8)!)
        return computed.map { String(format: "%02hhx", $0) }.joined()
    }
    
    //: ### Base64 encoding a string
    func base64Encoded() -> String? {
        if let data = self.data(using: .utf8) {
            return data.base64EncodedString()
        }
        return nil
    }
    
    //: ### Base64 decoding a string
    func base64Decoded() -> String? {
        if let data = Data(base64Encoded: self, options: .ignoreUnknownCharacters) {
            return String(data: data, encoding: .utf8)
        }
        return nil
    }
    
    func hmac(key: String) -> String {
        var digest = [UInt8](repeating: 0, count: Int(CC_SHA512_DIGEST_LENGTH))
        CCHmac(CCHmacAlgorithm(kCCHmacAlgSHA512), key, key.count, self, self.count, &digest)
        let data = Data(digest)
        return data.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: 0))
    }
    
//    func hmac(algorithm: CryptoAlgorithm, key: String) -> String {
//        let str = self.cString(using: String.Encoding.utf8)
//        let strLen = Int(self.lengthOfBytes(using: String.Encoding.utf8))
//        let digestLen = algorithm.digestLength
//        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
//        let keyStr = key.cString(using: String.Encoding.utf16)
//        let keyLen = Int(key.lengthOfBytes(using: String.Encoding.utf16))
//        
//        CCHmac(algorithm.HMACAlgorithm, keyStr!, keyLen, str!, strLen, result)
//        
//        let digest = stringFromResult(result: result, length: digestLen)
//        
//        result.deallocate()
//        
//        return digest
//    }
    
    private func stringFromResult(result: UnsafeMutablePointer<CUnsignedChar>, length: Int) -> String {
        let hash = NSMutableString()
        for i in 0..<length {
            hash.appendFormat("%02x", result[i])
        }
        return String(hash).lowercased()
    }
}
