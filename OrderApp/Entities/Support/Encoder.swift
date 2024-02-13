//
//  Encoder.swift
//  OrderApp
//
//  Created by Artyom on 12.02.24.
//

import Foundation
import UIKit

class Encoder {
    
    func strHash(_ str: String) -> UInt64 {
        var result = UInt64 (5381)
        let buf = [UInt8](str.utf8)
        for b in buf {
            result = 127 * (result & 0x00ffffffffffffff) + UInt64(b)
        }
        return result
    }
}
