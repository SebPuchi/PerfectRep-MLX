//
//  UnitConversion.swift
//  PerfectRep
//
//  Created by Sebastian Pucher on 6/10/24.
//

import Foundation

class UnitConversion {
    
    static func conversion(of value: Double, from unit1: Unit, to unit2: Unit) -> Double {
        let measurement = NSMeasurement(doubleValue: value, unit: unit1)
        return measurement.converting(to: unit2).value
    }
    
}
