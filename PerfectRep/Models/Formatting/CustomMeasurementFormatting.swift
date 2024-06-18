//
//  CustomMeasurementFormatting.swift
//  PerfectRep
//
//  Created by Sebastian Pucher on 6/12/24.
//

import Foundation

class CustomMeasurementFormatting {
    
    static func string(forMeasurement measurement: NSMeasurement, type: FormattingMeasurementType = .auto, rounding: FormattingRoundingType = .twoDigits) -> String {
        
        let formatter = MeasurementFormatter()
        formatter.unitOptions = .providedUnit
        
        switch rounding {
        case .wholeNumbers:
            formatter.numberFormatter.roundingIncrement = 1
        case .oneDigit:
            formatter.numberFormatter.roundingIncrement = 0.1
        case .twoDigits:
            formatter.numberFormatter.roundingIncrement = 0.01
        case .fourDigits:
            formatter.numberFormatter.roundingIncrement = 0.0001
        case .none:
            break
        }
        
        switch type {
        case .clock:
            let seconds = measurement.converting(to: UnitDuration.seconds).value
            let timeFormatter = DateComponentsFormatter()
            timeFormatter.unitsStyle = .positional
            timeFormatter.allowedUnits = [.hour, .minute, .second]
            timeFormatter.zeroFormattingBehavior = .pad
            return timeFormatter.string(from: seconds) ?? "Error"
        case .energy:
            return formatter.string(from: measurement.converting(to: UserPreferences.energyMeasurementType.safeValue))
        case .weight:
            return formatter.string(from: measurement.converting(to: UserPreferences.weightMeasurementType.safeValue))
        default:
            formatter.unitOptions = .naturalScale
            return formatter.string(from: measurement as Measurement)
        }
    }
    
    static func string(forUnit unit: Unit, short: Bool = false) -> String {
        let formatter = MeasurementFormatter()
        return short ? unit.symbol : formatter.string(from: unit)
    }
    
    enum FormattingMeasurementType {
        case clock, time
        case energy
        case weight
        case auto
        
        init(for unit: Unit, asClock: Bool = false, asAltitude: Bool = false) {
            switch unit {
            case is UnitDuration:
                self = asClock ? .clock : .time
            case is UnitEnergy:
                self = .energy
            case is UnitMass:
                self = .weight
            default:
                self = .auto
            }
        }
    }
    
    enum FormattingRoundingType {
        case wholeNumbers, oneDigit, twoDigits, fourDigits, none
    }
    
}
