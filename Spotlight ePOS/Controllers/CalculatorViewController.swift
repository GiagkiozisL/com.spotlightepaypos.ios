//
//  CalculatorViewController.swift
//  Spotlight ePOS
//
//  Created by Lu on 30/1/23.
//

import UIKit

class CalculatorViewController: UIViewController {

    
    @IBOutlet weak var amountTextField: UITextField!
    
    @IBOutlet weak var chargeBtn: UIButton!
    
    var order: Order?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initUI()
        
        print("order is: \(String(describing: order?.orderId))")
    }
    
    func initUI() {
        
        let customFont: UIFont = UIFont.init(name: (amountTextField.font?.fontName)!, size: 55.0)!
        amountTextField.font = customFont
        amountTextField.textColor = .black
        amountTextField.isUserInteractionEnabled = false
        amountTextField.frame.size.width = amountTextField.intrinsicContentSize.width
        amountTextField.text = String(order?.amount ?? 0)
        
        chargeBtn.setTitle("Charge \(order?.amount ?? 0) AED", for: .normal)
    }
}
