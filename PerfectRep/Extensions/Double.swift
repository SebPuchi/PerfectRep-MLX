//
//  Double.swift
//  PerfectRep
//
//  Created by Sebastian Pucher on 6/20/24.
//

import Foundation

extension Double {
    
    /**
     Rounds this value to a specified decimal place using the specifed `FloatingPointRoundingRule`
     - parameter decimalPlaces: the maximum number of decimal places the value should have
     - parameter rule: the rule by which the value will be rounded
     */
    mutating func round(decimalPlaces: Int = 0, rule: FloatingPointRoundingRule) {
        
        self = self.rounded(decimalPlaces: decimalPlaces, rule: rule)
    }
    
    /**
     Returns this value rounded to a specified decimal place using the specifed `FloatingPointRoundingRule`
     - parameter decimalPlaces: the maximum number of decimal places the value should have
     - parameter rule: the rule by which the value will be rounded
     - returns: the rounded value
     */
    func rounded(decimalPlaces: Int = 0, rule: FloatingPointRoundingRule) -> Double {
        
        let roundingFactor = Double(pow(10, Double(decimalPlaces)))
        
        return ( self * roundingFactor ).rounded(rule) / roundingFactor
        
    }
    
}
