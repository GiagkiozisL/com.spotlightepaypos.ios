//
//  Numeric.swift
//  Spotlight ePOS
//
//  Created by Lu on 20/1/23.
//

import Foundation


extension Numeric {
    var data: Data {
        var source = self
        return Data(bytes: &source, count: MemoryLayout<Self>.size)
    }
}
