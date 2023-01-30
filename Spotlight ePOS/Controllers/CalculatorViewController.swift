//
//  CalculatorViewController.swift
//  Spotlight ePOS
//
//  Created by Lu on 30/1/23.
//

import UIKit

class CalculatorViewController: UIViewController {

    
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var amountTextField: UITextField!
    
    @IBOutlet weak var chargeBtn: UIButton!
    var payload: String = ""
    var order: Order?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        parseOrder()
        initUI()
    }
    
    func initUI() {
        
        let customFont: UIFont = UIFont.init(name: (amountTextField.font?.fontName)!, size: 55.0)!
        amountTextField.font = customFont
        amountTextField.textColor = .black
        amountTextField.isUserInteractionEnabled = false
        amountTextField.frame.size.width = amountTextField.intrinsicContentSize.width
        amountTextField.text = String(order?.amount ?? 0)
        
        chargeBtn.setTitle("Charge \(order?.amount ?? 0) \(order?.currency ?? "")", for: .normal)
        currencyLabel.text = order?.currency ?? ""
    }
    
    func parseOrder() {
        do {
            let data: Data = payload.base64Decoded()
            order = try JSONDecoder().decode(Order.self, from: data)
        } catch {
            print("error on decoding base64 of payload \(error)")
        }
    }
}
