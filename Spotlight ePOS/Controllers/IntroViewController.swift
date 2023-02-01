//
//  IntroViewController.swift
//  Spotlight ePOS
//
//  Created by Lu on 30/1/23.
//

import Foundation
import UIKit

class IntroViewController: UIViewController {

    var payload = "ewogICJvcmRlcklkIjogIjQ2N2VlY2M2LTAwMDAtNGRjNy05NDE4LWUwMzhkMzQ5MWY3OSIsCiAgImFtb3VudCI6IDQ1OTksCiAgInN0b3JlSWQiOiAiNDAwMSIsCiAgImtleSI6ICJWZXJ5U2VjcmV0IiwKICAiY3VycmVuY3kiOiAiRVVSIgp9"
    
//    var payload: String = "ewogICJvcmRlcklkIjogIjQ2N2VlY2M2LWUzYWMtNGRjNy05NDE4LWUwMzhkMzQ5MTAwMCIsCiAgImFtb3VudCI6IDEwMCwKICAic3RvcmVJZCI6ICI0MDAxIiwKICAia2V5IjogIlZlcnlTZWNyZXQiLAogICJjdXJyZW5jeSI6ICJFVVIiCn0="
//
    override func viewDidLoad() {
        super.viewDidLoad()

        Task {
            try await Task.sleep(nanoseconds: 5_000_000) // 5 secs
//            testPinning()
//            testpinning2()
            showCalculatorVC(payload)
            
        }
    }
    
    func showCalculatorVC(_ data: String) {
        
        // push view controller but animate modally
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "CalculatorViewController") as! CalculatorViewController
        
        vc.payload = data
        let navigationController = self.navigationController
        
        let transition = CATransition()
        transition.duration = 0.8
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.moveIn
        transition.subtype = CATransitionSubtype.fromTop
        navigationController?.view.layer.add(transition, forKey: nil)
        navigationController?.pushViewController(vc, animated: false)
    }
    
//    func testPinning() {
//        guard let imageUrl = URL(string:
//          "https://demo.neopayments.gr:9443/") else {
//            return
//        }
//
//        // URL session that doesn't cache.
//        let urlSession = URLSession(configuration: URLSessionConfiguration.ephemeral)
//
//        let task = urlSession.dataTask(with: imageUrl) { imageData, response, error in
//            DispatchQueue.main.async {
//                // Handle client errors
//                if let error = error {
////                   self.HandleClientConnectionError(error: error)
//                    print("error: \(error)")
//                   return
//                }
//
//                // Handle server errors
//                guard let httpResponse = response as? HTTPURLResponse,
//                      (200...299).contains(httpResponse.statusCode) else {
//                    print("error: ??")
////                    self.HandleServerError(response: response!)
//                return
//                }
//                print("success??: ??")
////                self.AddImageToView(imageData: imageData!)
//            }
//        }
//
//        task.resume()
//    }
//
//    func testpinning2() {
//        let session = URLSession(
//                                configuration: URLSessionConfiguration.ephemeral,
//                                delegate: NSURLSessionPinningDelegate(),
//                                delegateQueue: OperationQueue.main)
////        session.dataTask(with: imageUrl)
//
//        guard let imageUrl = URL(string:
//          "https://demo.neopayments.gr:9443/") else {
//            return
//        }
//
//        let task = session.dataTask(with: imageUrl) { (data, response, error) in
//            print("data: \(data)")
//            print("response: \(response)")
//            print("error: \(error)")
//        }
//        task.resume()
//    }
}
