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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        Task {
            try await Task.sleep(nanoseconds: 5_000_000) // 5 secs
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
//        navigationController?.pushViewController(vc, animated: false)
        navigationController?.present(vc, animated: true)
    }

}
