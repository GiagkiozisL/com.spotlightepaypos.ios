//
//  CalculatorViewModel.swift
//  Spotlight ePOS
//
//  Created by Lu on 30/1/23.
//

import Foundation
import Combine

class CalculatorViewModel {
    
    
    @Published private(set) var error = ""
    @Published private(set) var isloading = false
    @Published private(set) var paymentSent = false
    
    
    private var dataService: DataService?
    
    // MARK: - Constructor
    init(dataService: DataService) {
        self.dataService = dataService
    }
    
    func createReceipt(_ receipt: PaymentReceipt) { // todo receipt must move to viewmodel
        isloading = true
        dataService?.postCreateReceipt(with: receipt, completion: { (success, errorMsg) in
            if (success) {
                // todo
                print("success!")
                self.isloading = false
                self.error = ""
                self.paymentSent = true
            } else {
                // todo
                print("error! \(String(describing: errorMsg))")
                self.isloading = false
                self.error = errorMsg ?? ""
            }
        })
    }
}
