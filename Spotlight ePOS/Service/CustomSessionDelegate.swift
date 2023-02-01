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
    }
    
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
