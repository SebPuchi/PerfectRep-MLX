//
//  CustomNumberFormatting.swift
//  PerfectRep
//
//  Created by Sebastian Pucher on 6/10/24.
//

import Foundation

class CustomNumberFormatting {
    
    static func number(from string: String?) -> Double? {
        guard let string = string else {
            return nil
        }
        let formatter = NumberFormatter()
        let value = formatter.number(from: string) as? Double
        return value
    }
    
    static func string(from double: Double, fractionDigits: Int = 2) -> String? {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = fractionDigits
        return numberFormatter.string(for: double)
    }
    
}
