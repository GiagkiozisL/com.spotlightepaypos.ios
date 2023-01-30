//
//  IntroViewController.swift
//  Spotlight ePOS
//
//  Created by Lu on 30/1/23.
//

import Foundation
import UIKit

class IntroViewController: UIViewController {

    var payload: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        Task {
            try await Task.sleep(nanoseconds: 5_000_000) // 5 secs
            
            var order = Order()
            do {
                let data: Data = payload.base64Decoded()
                order = try JSONDecoder().decode(Order.self, from: data)
            } catch {
                print("error on decoding base64 of payload \(error)")
            }
            showCalculatorVC(order)
        }
    }
    
    func showCalculatorVC(_ order: Order) {
        
        // push view controller but animate modally
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "CalculatorViewController") as! CalculatorViewController
        vc.order = order
        let navigationController = self.navigationController
        
        let transition = CATransition()
        transition.duration = 0.8
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.moveIn
        transition.subtype = CATransitionSubtype.fromTop
        navigationController?.view.layer.add(transition, forKey: nil)
        navigationController?.pushViewController(vc, animated: false)
    }

}
