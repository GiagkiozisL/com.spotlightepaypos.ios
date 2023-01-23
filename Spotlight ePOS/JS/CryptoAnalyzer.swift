//
//  CryptoAnalyzer.swift
//  Spotlight ePOS
//
//  Created by Lu on 23/1/23.
//

import Foundation
import JavaScriptCore


class CryptoAnalyzer {
    
    static let shared = CryptoAnalyzer() // treat as a singleton
    private let vm = JSVirtualMachine()
    private let context: JSContext
    
    private init() {
        
        let jsCode = try? String.init(contentsOf: Bundle.main.url(forResource: "Crypto.bundle", withExtension: "js")!)
        
        let nativeLog: @convention(block) (String) -> Void = { message in
            print("JS Log: \(message)")
        }
        
        // Create a new JavaScript context that will contain the state of our evaluated JS code.
        self.context = JSContext(virtualMachine: self.vm)
        
        // Register our native logging function in the JS context
        self.context.setObject(nativeLog, forKeyedSubscript: "nativeLog" as NSString)
        
        // Evaluate the JS code that defines the functions to be used later on.
        self.context.evaluateScript(jsCode)
    }
    
    func analyze(_ message: String, _ key: String) async -> String {
        let jsModule = self.context.objectForKeyedSubscript("Crypto")
        let jsAnalyzer = jsModule?.objectForKeyedSubscript("Analyzer")
        if let result = jsAnalyzer?.invokeMethod("analyze", withArguments: [message, key]) {
            return result.toString()
        }
        
        return ""
    }
}
