//
//  CalculatorViewController.swift
//  Spotlight ePOS
//
//  Created by Lu on 30/1/23.
//

import UIKit
import Combine

class CalculatorViewController: UIViewController {
    
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    
    @IBOutlet weak var chargeBtn: UIButton!
    
    @IBOutlet weak var resultImageView: UIImageView!
    
    var payload: String = ""
    var order: Order?
    
    private var subscriptions = Set<AnyCancellable>()
    
    // MARK: - Injection
    let viewModel = CalculatorViewModel(dataService: DataService())
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        parseOrder()
        initUI()
        setupBindings()
    }
    
    func initUI() {
        
        let customFont: UIFont = UIFont.init(name: (amountTextField.font?.fontName)!, size: 55.0)!
        amountTextField.font = customFont
        amountTextField.textColor = .black
        amountTextField.isUserInteractionEnabled = false
        amountTextField.frame.size.width = amountTextField.intrinsicContentSize.width
        let amountDec: Double = Double((order?.amount ?? 0) / 100)
        let formattedPrice = String(format: "%.2f", amountDec)
        amountTextField.text = formattedPrice
        
        chargeBtn.setTitle("Charge \(formattedPrice) \(order?.currency ?? "")", for: .normal)
        currencyLabel.text = order?.currency ?? "yo"
    }
    
    func parseOrder() {
        do {
            let data: Data = payload.base64Decoded()
            order = try JSONDecoder().decode(Order.self, from: data)
        } catch {
            print("error on decoding base64 of payload \(error)")
        }
    }
    
    private func setupBindings() {
        // Properties that can be assigned using default assign method
        subscriptions = [
            viewModel.$error.assign(to: \.text!, on: errorLabel)
        ]
        
        viewModel.$isloading
            .sink { loading in
                self.indicatorView.isHidden = !loading
            }.store(in: &subscriptions)
        
        viewModel.$paymentSent
            .sink { paymentSent in
                self.resultImageView.isHidden = !paymentSent
                if (paymentSent) {
                    self.chargeBtn.isEnabled = false
                    Task {
                        try await Task.sleep(nanoseconds: 3_000_000_000)
                        self.dismiss(animated: true)
                    }
                }
            }.store(in: &subscriptions)
    }
    
    @IBAction func chargeClicked(_ sender: Any) {
        
        guard order != nil else {
            //todo show message
            return
        }
        
        let paymentReciept = PaymentReceipt(order!)
        var hmac = Utils.calulateHmac(txn_type: paymentReciept.txnType,
                                      amount: paymentReciept.amount,
                                      store_id: paymentReciept.storeID,
                                      order_id: paymentReciept.orderID)
        
        Task {
            let hash = await CryptoAnalyzer.shared.analyze(hmac, order?.key ?? "")
            print("hash is: \(hash)")
            paymentReciept.digest = hash
            viewModel.createReceipt(paymentReciept)
        }
    }
}
