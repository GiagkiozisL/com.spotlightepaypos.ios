//
//  PKCS12.swift
//  Spotlight ePOS
//
//  Created by Lu on 1/2/23.
//

import Foundation


/**
 Struct representing values returned by `SecPKCS12Import` from the Security framework.
 
 This is what Cocoa and CocoaTouch can tell you about a PKCS12 file.
 
 */
public class PKCS12 {
    var label:String?
        var keyID:Data?
        var trust:SecTrust?
        var certChain:[SecTrust]?
        var identity:SecIdentity?

        let securityError:OSStatus

        public init(data:Data, password:String) {

            //self.securityError = errSecSuccess

            var items:CFArray?
            let certOptions:NSDictionary = [kSecImportExportPassphrase as NSString:password as NSString]

            // import certificate to read its entries
            self.securityError = SecPKCS12Import(data as NSData, certOptions, &items);

            if securityError == errSecSuccess {
                let certItems:Array = (items! as Array)
                let dict:Dictionary<String, AnyObject> = certItems.first! as! Dictionary<String, AnyObject>;

                self.label = dict[kSecImportItemLabel as String] as? String;
                self.keyID = dict[kSecImportItemKeyID as String] as? Data;
                self.trust = dict[kSecImportItemTrust as String] as! SecTrust?;
                self.certChain = dict[kSecImportItemCertChain as String] as? Array<SecTrust>;
                self.identity = dict[kSecImportItemIdentity as String] as! SecIdentity?;
            }
        }

        public convenience init(mainBundleResource:String, resourceType:String, password:String) {
            self.init(data: NSData(contentsOfFile: Bundle.main.path(forResource: mainBundleResource, ofType:resourceType)!)! as Data, password: password);
        }

        public func urlCredential()  -> URLCredential  {
            return URLCredential(
                identity: self.identity!,
                certificates: self.certChain!,
                persistence: URLCredential.Persistence.forSession);

        }

}

extension URLCredential {
  public convenience init?(PKCS12 thePKCS12:PKCS12) {
    if let identity = thePKCS12.identity {
      self.init(
        identity: identity,
        certificates: thePKCS12.certChain,
        persistence: URLCredential.Persistence.forSession)
    }
    else { return nil }
  }
}
