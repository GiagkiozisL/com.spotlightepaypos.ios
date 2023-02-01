//
//  CustomSessionDelegate.swift
//  Spotlight ePOS
//
//  Created by Lu on 31/1/23.
//

import Foundation

import Alamofire

public class CustomSessionDelegate: SessionDelegate {
    
    public static var sharedInstance = CustomSessionDelegate()
    public override func urlSession(_ session: URLSession,
                                    task: URLSessionTask,
                                    didReceive challenge: URLAuthenticationChallenge,
                                    completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        
        let cert = PKCS12.init(mainBundleResource: "nsf-api-spotlight.test", resourceType: "pfx", password: "nsfSp0tL!ght");
        
        completionHandler(.useCredential, URLCredential(PKCS12: cert))
        
        
//        if let serverTrust = challenge.protectionSpace.serverTrust {
//            /* do pinning validation (your pinning logic should come here. As discussed above you can either * Pin the Certificate / * Pin the public keys) */
//
//            completionHandler(.useCredential, URLCredential(trust: serverTrust))
//
//            // Compare the server certificate with our own stored
//          if let serverCertificate = SecTrustGetCertificateAtIndex(serverTrust, 0) {
//              let serverCertificateData = SecCertificateCopyData(serverCertificate) as Data
//
//              if pinnedCertificates().contains(serverCertificateData) {
//                  completionHandler(.useCredential, URLCredential(trust: serverTrust))
//                  return
//              }
//          }
//
//            completionHandler(.cancelAuthenticationChallenge, nil)
//            return
//        }
//        // Pinning failed
//        completionHandler(.cancelAuthenticationChallenge, nil)
    }
    
//    func getClientUrlCredential() -> URLCredential {
//
//            let userCertificate = certificateHelper.getCertificateNSData(withName: "nsf-api-spotlight.test",
//                                                                         andExtension: "pfx")
//            let userIdentityAndTrust = certificateHelper.extractIdentityAndTrust(fromCertificateData: userCertificate, certPassword: "nsfSp0tL!ght")
//            //Create URLCredential
//            let urlCredential = URLCredential(identity: userIdentityAndTrust.identityRef,
//                                              certificates: userIdentityAndTrust.certArray as [AnyObject],
//                                              persistence: URLCredential.Persistence.permanent)
//
//            return urlCredential
//        }
    
    static func sessionConfig() -> URLSessionConfiguration {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 4 * 60.0
        configuration.timeoutIntervalForResource = 4 * 60 // 4 mins
        return configuration
    }
    
    private func pinnedCertificates() -> [Data] {
        var certificates: [Data] = []

        if let pinnedCertificateURL = Bundle.main.url(forResource: "neosoft", withExtension: "pem") {
            do {
                let pinnedCertificateData = try Data(contentsOf: pinnedCertificateURL)
                certificates.append(pinnedCertificateData)
            } catch {
                // Handle error
            }
        }

        return certificates
    }
}
