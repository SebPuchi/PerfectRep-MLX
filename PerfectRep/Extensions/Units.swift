//
//  Units.swift
//  PerfectRep
//
//  Created by Sebastian Pucher on 6/10/24.
//

import Foundation


protocol StandardizedUnit {
    
    static var standardUnit: Unit { get }
    static var standardBigUnit: Unit { get }
    static var standardBigLocalUnit: Unit { get }
    static var standardSmallLocalUnit: Unit { get }
    
}


extension UnitEnergy: StandardizedUnit {
    
    static var standardUnit: Unit {
        get {
            return UnitEnergy.calories
        }
    }
    
    static var standardBigUnit: Unit {
        get {
            return UnitEnergy.kilocalories
        }
    }
    
    static var standardBigLocalUnit: Unit {
        get {
            return standardBigUnit
        }
    }
    
    static var standardSmallLocalUnit: Unit {
        get {
            return standardUnit
        }
    }
}

extension UnitMass: StandardizedUnit {
    
    static var standardUnit: Unit {
        get {
            return UnitMass.pounds
        }
    }
    
    static var standardBigUnit: Unit {
        get {
            return UnitMass.kilograms
        }
    }
    
    static var standardBigLocalUnit: Unit {
        get {
            return Locale.current.measurementSystem == .metric ? UnitMass.kilograms : UnitMass.pounds
        }
    }
    
    static var standardSmallLocalUnit: Unit {
        get {
            return Locale.current.measurementSystem == .metric ? UnitMass.grams : UnitMass.ounces
        }
    }
}
