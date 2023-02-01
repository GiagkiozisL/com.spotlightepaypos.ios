//
//  DataService.swift
//  Spotlight ePOS
//
//  Created by Lu on 30/1/23.
//

import Foundation
import Alamofire


struct DataService {
    
    // MARK: - Singleton
    static let shared = DataService()
    
    // MARK: - URL
    private var baseUrl = "https://demo.neopayments.gr:9443/cpr-orders/ws/erp"
    private var cprCreate = "/cprcreate"
    
    private var session: Alamofire.Session
  
    init() {
        
        let serverTrustPolicies: [String: ServerTrustEvaluating] = [
                "demo.neopayments.gr": DisabledTrustEvaluator()]

        let manager = ServerTrustManager(evaluators: serverTrustPolicies)
        session = Session(delegate: CustomSessionDelegate(), serverTrustManager: manager)
    }
    
    // MARK: - Services
    func postCreateReceipt(with receipt: PaymentReceipt, completion: @escaping (Bool, String?) -> ()) {
        
        let heads: HTTPHeaders = [HTTPHeader(name: "Content-Type", value: "application/json")]
        session.request(baseUrl + cprCreate, method: .post, parameters: receipt, encoder: JSONParameterEncoder.default, headers: heads).response { response in
            print(response)
            switch (response.result) {
            case .success:
                print("request succeded \(String(describing: response.response?.statusCode))")
                if let data = response.data {
                    let json = String(data: data, encoding: String.Encoding.utf8)
                    print("request Response: \(String(describing: json))")
                }
                completion(true, "")
                break
            case .failure(let error):
                print("request failed with status code: \(String(describing: response.response?.statusCode))")
                let error = getReceiptErrorByCode(response.response?.statusCode ?? 500, error.localizedDescription)
                completion(false, error)
                break
            }
        }
        
        func getReceiptErrorByCode(_ code: Int, _ defError: String) -> String {
            switch (code) {
            case 404:
                return "Store/POS not found"
            case 429:
                return "Pending request for the EFT/POS exists"
            case 503:
                return "Internal service error"
            default:
                return defError
            }
        }
    }
}
