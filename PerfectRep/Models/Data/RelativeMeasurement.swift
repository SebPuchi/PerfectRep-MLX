//
//  RelativeMeasurement.swift
//  PerfectRep
//
//  Created by Sebastian Pucher on 6/10/24.
//

import Foundation

class RelativeMeasurement {
    
    private var primaryMeasurement: Measurement<Unit>
    private var dividingMeasurement: Measurement<Unit>
    
    var value: Double {
        let value = (primaryMeasurement.value / dividingMeasurement.value)
        return value.isFinite ? value : 0
    }
    
    var stringRepresentation: String {
        if primaryMeasurement.unit is UnitDuration {
            let formatter = DateComponentsFormatter()
            formatter.unitsStyle = .positional
            formatter.zeroFormattingBehavior = .pad
            formatter.allowedUnits = [.minute, .second]
            let seconds = NSMeasurement(doubleValue: value, unit: primaryMeasurement.unit).converting(to: UnitDuration.seconds).value
            return formatter.string(from: seconds) ?? "--"
        } else {
            return CustomNumberFormatting.string(from: self.value, fractionDigits: 2) ?? "--"
        }
    }
    
    var stringRepresentationWithUnit: String {
        return self.stringRepresentation + " " + self.relativeUnit
    }
    
    var relativeUnit: String {
        let formatter = MeasurementFormatter()
        formatter.unitOptions = .providedUnit
        return formatter.string(from: primaryMeasurement.unit) + "/" + formatter.string(from: dividingMeasurement.unit)
    }
    
    init(primary: Measurement<Unit>, dividing: Measurement<Unit>) {
        
        self.primaryMeasurement = primary
        self.dividingMeasurement = dividing
        
    }
    
    convenience init(value: Double, primaryUnit: Unit, dividingUnit: Unit) {
        let primaryMeasurement = Measurement(value: value, unit: primaryUnit)
        let dividingMeasurement = Measurement(value: 1, unit: dividingUnit)
        self.init(primary: primaryMeasurement, dividing: dividingMeasurement)
    }
    
}
